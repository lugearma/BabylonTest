//
//  PersistentClient.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/27/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation
import CoreData

protocol PersistentClientProtocol {
    func fetchPosts(completion: @escaping PostsResult)
    func savePosts(_ posts: [Post])
}

class PersistentClient: PersistentClientProtocol {
    
    let persistentManager: PersistentManagerProtocol
    
    init(persistentManager: PersistentManagerProtocol) {
        self.persistentManager = persistentManager
    }
    
    func fetchPosts(completion: @escaping PostsResult) {
        let request = NSFetchRequest<ManagedPost>(entityName: "ManagedPost")
        let data = persistentManager.fetchData(request: request)
        switch data {
        case .success(let managedPosts):
            let posts = managedPosts.map { Post(userId: Int($0.userId), id: Int($0.id), title: $0.title ?? "", body: $0.body ?? "") }
            completion(.success(posts))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    func savePosts(_ posts: [Post]) {
        
    }
    
    func fetchUser(completion: @escaping UserResult) {
        
    }
    
    func saveUser() {
        
    }
    
    
    
    
}
