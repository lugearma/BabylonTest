//
//  PostDetailCoordinator.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/23/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit

class PostDetailCoordinator: CoordinatorProtocol {
    
    let navigationController: UINavigationController
    let userRepository: UserRepositoryProtocol
    let commentRepository: CommentRespositoryProtocol
    let apiClient: APIClientProtocol
    let post: Post
    
    init(navigationController: UINavigationController, apiClient: APIClientProtocol, post: Post) {
        self.navigationController = navigationController
        self.apiClient = apiClient
        self.userRepository = UserRepository(apiClient: apiClient)
        self.commentRepository = CommentRepository(apiClient: apiClient)
        self.post = post
    }
    
    func start() {
        let postDetailViewController = configurePostDetailViewController()
        navigationController.pushViewController(postDetailViewController, animated: true)
    }
    
    private func configurePostDetailViewController() -> PostDetailViewController {
        let postDetailViewModel = PostDetailViewModel(repository: userRepository, commentRepository: commentRepository, post: post)
        let postDetailViewController = PostDetailViewController(viewModel: postDetailViewModel)
        return postDetailViewController
    }
}
