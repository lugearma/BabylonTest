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

protocol PersistentClientProtocol: APIClientProtocol {
    func savePosts(_ posts: [Post])
    func saveUser(_ user: User)
    func saveComments(_ comments: [Comment])
}

class PersistentClient: PersistentClientProtocol {
    
    let persistentManager: PersistentManagerProtocol
    
    init(persistentManager: PersistentManagerProtocol) {
        self.persistentManager = persistentManager
    }
    
    func savePosts(_ posts: [Post]) {
        for post in posts {
            persistentManager.insertNewData(for: "ManagedPost") { managedObject in
                guard let newPost = managedObject as? ManagedPost else { return }
                newPost.body = post.body
                newPost.title = post.title
                newPost.id = Int32(post.id)
                newPost.userId = Int32(post.userId)
            }
        }
        persistentManager.commitChanges()
        print("✅ Posts saved successfully")
    }
    
    func saveuser(_ user: User) {
        
    }
    
    func posts(completion: @escaping PostsResult) {
        let request = NSFetchRequest<ManagedPost>(entityName: "ManagedPost")
        let data = persistentManager.fetchData(request: request)
        switch data {
        case .success(let managedPosts):
            // TODO: Refactor this.
            let posts = managedPosts.map { Post(userId: Int($0.userId), id: Int($0.id), title: $0.title ?? "", body: $0.body ?? "") }
            completion(.success(posts))
        case .failure:
            completion(.failure(PersistentClientError.unableToFetchData))
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
        persistentManager.insertNewData(for: "ManagedUser") { managedObject in
            guard let managedUser = managedObject as? ManagedUser else { return }
            managedUser.email = user.email
            managedUser.id = Int32(user.id)
            managedUser.name = user.name
        }
        persistentManager.commitChanges()
        print("✅ Saved User: \(user)")
    }
    
    func commentsBy(postId: String, completion: @escaping CommentsResult) {
        
    }
    
    func saveComments(_ comments: [Comment]) {
        
    }
}
