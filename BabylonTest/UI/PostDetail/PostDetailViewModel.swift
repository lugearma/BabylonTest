//
//  PostDetailViewModel.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/23/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

protocol PostDetailViewModelDelegate: AnyObject {
    func didReceivePost(_ post: Post)
    func didThrowError(_ error: Error)
}

class PostDetailViewModel {
    
    weak var delegate: PostDetailViewModelDelegate?
    let postRepository: PostRepositoryProtocol
    let postId: String
    
    init(repository: PostRepositoryProtocol, postId: String) {
        self.postRepository = repository
        self.postId = postId
    }
    
    func fetchPost() {
        postRepository.postBy(id: postId) { [unowned self] result in
            switch result {
            case .success(let post):
                self.delegate?.didReceivePost(post)
            case .failure(let error):
                self.delegate?.didThrowError(error)
            }
        }
    }
}
