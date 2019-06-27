//
//  PostRepository.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/23/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

protocol PostRepositoryProtocol {
    var apiClient: APIClientProtocol { get }
    var persistentClient: PersistentClientProtocol { get }
    init(apiClient: APIClientProtocol, persistentClient: PersistentClientProtocol)
    
    func posts(completion: @escaping PostsResult)
    func postsFromPersistence(completion: @escaping PostsResult)
}

class PostRepository: PostRepositoryProtocol {
    
    let apiClient: APIClientProtocol
    let persistentClient: PersistentClientProtocol
    
    required init(apiClient: APIClientProtocol, persistentClient: PersistentClientProtocol) {
        self.apiClient = apiClient
        self.persistentClient = persistentClient
    }
    
    func posts(completion: @escaping PostsResult) {
        apiClient.posts(completion: completion)
    }
    
    func postsFromPersistence(completion: @escaping PostsResult) {
        persistentClient.fetchPosts(completion: completion)
    }
}
