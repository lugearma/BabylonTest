//
//  UserRepositoryTest.swift
//  BabylonTestTests
//
//  Created by Luis Arias on 6/25/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import XCTest
@testable import BabylonTest

class UserRepositoryTest: XCTestCase {
    
    var apiClient: APIClientProtocol!
    var userRepository: UserRepositoryProtocol!
    
    override func setUp() {
        apiClient = APIClient()
        userRepository = UserRepository(apiClient: apiClient)
    }
    
    func testGetUserById() {
        let exp = expectation(description: "User by id expectation")
        let id = 2
        userRepository.userBy(id: id) { result in
            switch result {
            case .success(let user):
                XCTAssertEqual(user.id, 2)
            case .failure(let error):
                switch (error as? DecodingError) {
                case .dataCorrupted(let context)?:
                    XCTFail(context.debugDescription)
                case .keyNotFound(let key, let context)?:
                    XCTFail("Key not found: \(key), context: \(context)")
                case .typeMismatch(let type, let context)?:
                    XCTFail("Type Mismatch for type: \(type), context: \(context)")
                case .valueNotFound(let type, let context)?:
                    XCTFail("Value not found for type: \(type), context: \(context)")
                default:
                    XCTFail(error.localizedDescription)
                }
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10.0)
    }
}
