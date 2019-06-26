//
//  UserRepository.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/23/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

protocol UserRepositoryProtocol {
    var apiClient: APIClientProtocol { get }
    init(apiClient: APIClientProtocol)
    
    func userBy(id: Int, completion: @escaping UserResult)
}

class UserRepository: UserRepositoryProtocol {
    var apiClient: APIClientProtocol
    
    required init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func userBy(id: Int, completion: @escaping UserResult) {
        apiClient.userBy(id: "\(id)", completion: completion)
    }
}
