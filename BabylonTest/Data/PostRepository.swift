//
//  PostRepository.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/23/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

protocol PostRepositoryProtocol {
    var apiClient: DataClientProtocol { get }
    init(apiClient: DataClientProtocol)
    
    func posts(completion: @escaping PostsResult)
}

class PostRepository: PostRepositoryProtocol {
    
    let apiClient: DataClientProtocol
    
    required init(apiClient: DataClientProtocol) {
        self.apiClient = apiClient
    }
    
    func posts(completion: @escaping PostsResult) {
        apiClient.posts(completion: completion)
    }
}
