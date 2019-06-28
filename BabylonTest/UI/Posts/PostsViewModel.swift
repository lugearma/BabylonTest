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
    let persistentClient: PersistentClientProtocol
    
    init(repository: PostRepositoryProtocol, persistentClient: PersistentClientProtocol) {
        self.postRepository = repository
        self.persistentClient = persistentClient
    }
    
    func fetchPosts() {
        postRepository.posts { [unowned self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.persistentClient.savePosts(posts)
                    self.delegate?.didReceivePosts(posts)
                case .failure(let error):
                    if (error as? APIClientError) == .noInternetConnection {
                        self.fetchPostFromPersistence()
                    } else {
                        self.delegate?.didThrow(error)
                    }
                }
            }
        }
    }
    
    private func fetchPostFromPersistence() {
        persistentClient.posts { [unowned self] result in
            switch result {
            case .success(let posts):
                self.delegate?.didReceivePosts(posts)
            case .failure(let error):
                self.delegate?.didThrow(error)
            }
        }
    }
    
    func pushToPostDetail(post: Post) {
        coordinatorDelegate?.postsPushToPostDetail(post: post)
    }
}
