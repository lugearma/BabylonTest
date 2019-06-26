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
    func didThrow(error: Error)
}

class PostDetailViewModel {
    
    weak var delegate: PostDetailViewModelDelegate?
    private let userRepository: UserRepositoryProtocol
    private let commentRepository: CommentRespositoryProtocol
    private var postDetailGroup = DispatchGroup()
    
    var user: User?
    let post: Post
    var comments: [Comment] = []
    
    
    init(repository: UserRepositoryProtocol, commentRepository: CommentRespositoryProtocol, post: Post) {
        self.userRepository = repository
        self.commentRepository = commentRepository
        self.post = post
    }
    
    func fetchPostDetails() {
        fetchUser()
        fetchCommments()
        postDetailGroup.notify(queue: .main, execute: fetchCompleted)
    }
    
    private func fetchUser() {
        postDetailGroup.enter()
        userRepository.userBy(id: post.userId) { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                self.delegate?.didThrow(error: error)
            }
            self.postDetailGroup.leave()
        }
    }
    
    private func fetchCommments() {
        postDetailGroup.enter()
        commentRepository.commentsBy(postId: post.id) { result in
            switch result {
            case .success(let comments):
                self.comments = comments
            case .failure(let error):
                self.delegate?.didThrow(error: error)
            }
            self.postDetailGroup.leave()
        }
    }
    
    private func fetchCompleted() {
        guard let user = user else {
            // TODO: Notify error to delegate
            return
        }
        let postDetail = PostDetail(user: user, body: post.body, numberOfComments: comments.count)
        delegate?.didReceivePostDetail(postDetail: postDetail)
    }
}
