//
//  PersistentClient.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/27/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation
import CoreData

enum PersistentClientError: Error {
    case dataNotFound
    case unableToFetchData
}

protocol PersistentClientProtocol: DataClientProtocol {
    func savePosts(_ posts: [Post])
    func saveUser(_ user: User)
    func saveComments(_ comments: [Comment])
}

class PersistentClient: PersistentClientProtocol {
    
    private let persistentManager: PersistentManagerProtocol
    
    init(persistentManager: PersistentManagerProtocol) {
        self.persistentManager = persistentManager
    }
    
    func posts(completion: @escaping PostsResult) {
        let request = NSFetchRequest<ManagedPost>(entityName: "ManagedPost")
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        let data = persistentManager.fetchData(request: request)
        switch data {
        case .success(let managedPosts):
            let posts = managedPosts.map { Post(userId: Int($0.userId), id: Int($0.id), title: $0.title ?? "", body: $0.body ?? "") }
            completion(.success(posts))
        case .failure:
            completion(.failure(PersistentClientError.unableToFetchData))
        }
    }
    
    func savePosts(_ posts: [Post]) {
        defer {
            persistentManager.commitChanges()
        }
        
        let filteredPosts = posts.filter { post in
            !existObjectWith(id: post.id, for: "ManagedPost")
        }
        
        for post in filteredPosts {
            persistentManager.insertNewData(for: "ManagedPost") { (newPost: ManagedPost) in
                newPost.body = post.body
                newPost.title = post.title
                newPost.id = Int32(post.id)
                newPost.userId = Int32(post.userId)
            }
        }
    }
    
    func existObjectWith(id: Int, for entityName: String) -> Bool {
        let fetch = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetch.predicate = NSPredicate(format: "id == %@", "\(id)")
        let data = persistentManager.fetchData(request: fetch)
        switch data {
        case .success(let objects):
            return objects.count != 0
        case .failure:
            return false
        }
    }
    
    func userBy(id: String, completion: @escaping UserResult) {
        let request = NSFetchRequest<ManagedUser>(entityName: "ManagedUser")
        request.predicate = NSPredicate(format: "id == %@", id)
        let data = persistentManager.fetchData(request: request)
        switch data {
        case .success(let managedUsers):
            guard let user = managedUsers.first else {
                completion(.failure(PersistentClientError.dataNotFound))
                return
            }
            completion(.success(User(id: Int(user.id), name: user.name ?? "", email: user.email ?? "")))
        case .failure:
            completion(.failure(PersistentClientError.unableToFetchData))
        }
    }
    
    func saveUser(_ user: User) {
        defer {
            persistentManager.commitChanges()
        }
        
        let needsSaveUser = !existObjectWith(id: user.id, for: "ManagedUser")
        guard needsSaveUser else { return }
        
        persistentManager.insertNewData(for: "ManagedUser") { (managedUser: ManagedUser) in
            managedUser.email = user.email
            managedUser.id = Int32(user.id)
            managedUser.name = user.name
        }
    }
    
    func commentsBy(postId: String, completion: @escaping CommentsResult) {
        let request = NSFetchRequest<ManagedComment>(entityName: "ManagedComment")
        request.predicate = NSPredicate(format: "postId == %@", postId)
        let data = persistentManager.fetchData(request: request)
        switch data {
        case .success(let managedComments):
            guard !managedComments.isEmpty else {
                completion(.failure(PersistentClientError.dataNotFound))
                return
            }
            
            let comments = managedComments.map { Comment(postId: Int($0.postId), id: Int($0.id), name: $0.name ?? "", email: $0.email ?? "", body: $0.body ?? "") }
            completion(.success(comments))
        case .failure:
            completion(.failure(PersistentClientError.unableToFetchData))
        }
    }
    
    func saveComments(_ comments: [Comment]) {
        defer {
            persistentManager.commitChanges()
        }
        
        let filteredComments = comments.filter { comment in
            !existObjectWith(id: comment.id, for: "ManagedComment")
        }
        
        for comment in filteredComments {
            persistentManager.insertNewData(for: "ManagedComment") { managedObject in
                guard let newComment = managedObject as? ManagedComment else { return }
                newComment.id = Int32(comment.id)
                newComment.postId = Int32(comment.postId)
                newComment.name = comment.name
                newComment.body = comment.body
                newComment.email = comment.email
            }
        }
    }
}
