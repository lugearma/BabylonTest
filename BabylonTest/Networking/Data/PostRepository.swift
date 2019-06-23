//
//  PostRepository.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/23/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

protocol PostRepositoryProtocol {
    var apiClient: APIClietProtocol { get }
    init(apiClient: APIClietProtocol)
    
    func posts(completion: @escaping PostsResult)
}

class PostRepository: PostRepositoryProtocol {
    
    var apiClient: APIClietProtocol
    
    required init(apiClient: APIClietProtocol) {
        self.apiClient = apiClient
    }
    
    func posts(completion: @escaping PostsResult) {
        apiClient.posts(completion: completion)
    }
}
