//
//  PostsViewModel.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/18/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

protocol PostsViewModelCoodinatorDelegate: AnyObject {
    func postsPushToPostDetail(post: Post)
}

protocol PostsViewModelDelegate: AnyObject {
    func didReceivePosts(_ posts: [Post])
    func didThrow(_ error: Error)
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
                    guard let apiError = error as? APIClientError else {
                        self.delegate?.didThrow(error)
                        return
                    }
                    self.manageAPIErrors(error: apiError)
                }
            }
        }
    }
    
    private func manageAPIErrors(error: APIClientError) {
        switch error {
        case .noInternetConnection:
            self.postRepository.postsFromPersistence { result in
                switch result {
                case .success(let posts):
                    self.delegate?.didReceivePosts(posts)
                case .failure(let error):
                    self.delegate?.didThrow(error)
                }
            }
        case .missingData:
            delegate?.didThrow(error)
        }
    }
    
    func pushToPostDetail(post: Post) {
        coordinatorDelegate?.postsPushToPostDetail(post: post)
    }
}
