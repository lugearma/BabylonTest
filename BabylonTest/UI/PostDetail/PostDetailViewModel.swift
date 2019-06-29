//
//  PostDetailViewModel.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/23/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

protocol PostDetailViewModelDelegate: AnyObject {
    func didReceivePostDetail(postDetail: PostDetail)
    func didThrow(_ error: Error)
}

class PostDetailViewModel {
    
    weak var delegate: PostDetailViewModelDelegate?
    private let userRepository: UserRepositoryProtocol
    private let commentRepository: CommentRespositoryProtocol
    private var postDetailGroup = DispatchGroup()
    private let persistentClient: PersistentClientProtocol
    
    let post: Post
    var user: User?
    var comments: [Comment]?
    
    
    init(repository: UserRepositoryProtocol, commentRepository: CommentRespositoryProtocol, persistentClient: PersistentClientProtocol, post: Post) {
        self.userRepository = repository
        self.commentRepository = commentRepository
        self.persistentClient = persistentClient
        self.post = post
    }
    
    func fetchPostDetails() {
        fetchUser()
        fetchCommments()
        postDetailGroup.notify(queue: .main, execute: fetchCompleted)
    }
    
    private func fetchUser() {
        postDetailGroup.enter()
        userRepository.userBy(id: post.userId) { [unowned self] result in
            switch result {
            case .success(let user):
                self.persistentClient.saveUser(user)
                self.user = user
            case .failure(let error):
                if (error as? APIClientError) == .noInternetConnection {
                    self.fetchUserFromPersistence()
                } else {
                    self.delegate?.didThrow(error)
                }
            }
            self.postDetailGroup.leave()
        }
    }

    private func fetchCommments() {
        postDetailGroup.enter()
        commentRepository.commentsBy(postId: post.id) { [unowned self] result in
            switch result {
            case .success(let comments):
                self.persistentClient.saveComments(comments)
                self.comments = comments
            case .failure(let error):
                if (error as? APIClientError) == .noInternetConnection {
                    self.fetchCommentsFromPersistent()
                } else {
                    self.delegate?.didThrow(error)
                }
            }
            self.postDetailGroup.leave()
        }
    }
    
    private func fetchCompleted() {
        guard let user = user, let comments = comments else {
            delegate?.didThrow(PersistentClientError.dataNotFound)
            return
        }
        let postDetail = PostDetail(user: user, body: post.body, numberOfComments: comments.count)
        delegate?.didReceivePostDetail(postDetail: postDetail)
    }
}

// MARK: - Persistent Utils

extension PostDetailViewModel {
    
    private func fetchUserFromPersistence() {
        persistentClient.userBy(id: "\(post.userId)") { [unowned self] result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                self.delegate?.didThrow(error)
            }
        }
    }
    
    private func fetchCommentsFromPersistent() {
        persistentClient.commentsBy(postId: "\(post.id)") { result in
            switch result {
            case .success(let comments):
                self.comments = comments
            case .failure(let error):
                self.delegate?.didThrow(error)
            }
        }
    }
}
