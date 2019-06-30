//
//  PostRepositoryTest.swift
//  BabylonTestTests
//
//  Created by Luis Arias on 6/25/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import XCTest
@testable import BabylonTest

class PostRepositoryTest: XCTestCase {
    
    var apiClient: DataClientProtocol!
    var postRepository: PostRepositoryProtocol!
    
    override func setUp() {
        apiClient = APIClient()
        postRepository = PostRepository(apiClient: apiClient)
    }
    
    func testGetAllPosts() {
        let exp = expectation(description: "All Posts")
        postRepository.posts { result in
            switch result {
            case .success(let posts):
                let first = posts.first
                XCTAssertNotNil(first?.body)
                XCTAssertNotNil(first?.userId)
                XCTAssertNotNil(first?.id)
                XCTAssertNotNil(first?.title)
            case .failure(let error):
                switch (error as? DecodingError) {
                case .dataCorrupted(let context)?:
                    XCTFail(context.debugDescription)
                case .keyNotFound(let key, let context)?:
                    XCTFail("Key not found: \(key), context: \(context)")
                case .typeMismatch(let type, let context)?:
                    XCTFail("Type Mismatch for type: \(type), context: \(context)")
                case .valueNotFound(let type, let context)?:
                    XCTFail("Value not found for type \(type), context: \(context)")
                default:
                    XCTFail(error.localizedDescription)
                }
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10.0)
    }
    
}
