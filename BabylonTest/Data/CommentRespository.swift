//
//  CommentRespository.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/25/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

protocol CommentRespositoryProtocol {
    var apiClient: APIClientProtocol { get set }
    init(apiClient: APIClientProtocol)
    
    func commentsBy(postId: Int, completion: @escaping CommentsResult)
}

class CommentRepository: CommentRespositoryProtocol {
    
    var apiClient: APIClientProtocol
    
    required init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func commentsBy(postId: Int, completion: @escaping CommentsResult) {
        apiClient.commentsBy(postId: "\(postId)", completion: completion)
    }
}
