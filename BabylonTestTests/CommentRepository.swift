//
//  CommentRepository.swift
//  BabylonTestTests
//
//  Created by Luis Arias on 6/25/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import XCTest
@testable import BabylonTest

class CommmentRepositoryTest: XCTestCase {
    
    var apiClient: APIClient!
    var commentRepository: CommentRespositoryProtocol!
    
    override func setUp() {
        apiClient = APIClient()
        commentRepository = CommentRepository(apiClient: apiClient)
    }
    
    func testGetCommentsByPostId() {
        let exp = expectation(description: "Get comments by post ID expectation")
        let postId = 1
        commentRepository.commentsBy(postId: postId) { result in
            switch result {
            case .success(let comments):
                XCTAssertEqual(comments.first?.postId, 1)
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
