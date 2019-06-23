//
//  PostsViewModel.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/18/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

protocol PostsViewModelCoodinatorDelegate: AnyObject {
    func presentPost(for id: String)
}

protocol PostsViewModelDelegate: AnyObject {
    func didReceivePosts(_ posts: [Post])
    func didThrowError(_ error: Error)
}

final class PostsViewModel {
    
    weak var delegate: PostsViewModelDelegate?
    weak var coordinatorDelegate: PostsViewModelCoodinatorDelegate?
    let postRepository: PostRepositoryProtocol
    
    init(repository: PostRepositoryProtocol) {
        self.postRepository = repository
    }
    
    func fetchPosts() {
        postRepository.posts { [unowned self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.delegate?.didReceivePosts(posts)
                case .failure(let error):
                    self.delegate?.didThrowError(error)
                }
            }
        }
    }
    
    func presentPostDetail(for id: String) {
        coordinatorDelegate?.presentPost(for: id)
    }
}
