//
//  PostCoordinator.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/23/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit

enum PostsFlow {
    case postDetail
}

protocol PostsCoordinatorDelegate: AnyObject {
}

class PostsCoordinator: CoordinatorProtocol {
    
    private var apiClient: DataClientProtocol
    private var navigationController: UINavigationController
    private var postRespository: PostRepositoryProtocol
    private var persistentClient: PersistentClientProtocol
    
    private lazy var postsController: PostsViewController = configureController()
    
    weak var delegate: PostsCoordinatorDelegate?
    private var coordinators: [PostsFlow : CoordinatorProtocol] = [:]
    
    init(navigationController: UINavigationController, apiClient: DataClientProtocol, persistentClient: PersistentClientProtocol) {
        self.navigationController = navigationController
        self.apiClient = apiClient
        self.postRespository = PostRepository(apiClient: apiClient)
        self.persistentClient = persistentClient
    }
    
    func start() {
        navigationController.pushViewController(postsController, animated: true)
    }
    
    private func configureController() -> PostsViewController {
        let viewModel = PostsViewModel(repository: postRespository, persistentClient: persistentClient)
        viewModel.coordinatorDelegate = self
        let postsViewController = PostsViewController(viewModel: viewModel)
        return postsViewController
    }
}

// MARK: - PostsViewModelCoodinatorDelegate

extension PostsCoordinator: PostsViewModelCoodinatorDelegate {
    
    func postsPushToPostDetail(post: Post) {
        showPostDetail(post: post)
    }
    
    private func showPostDetail(post: Post) {
        let coordinator = PostDetailCoordinator(navigationController: navigationController, apiClient: apiClient, persistentClient: persistentClient, post: post)
        coordinators[.postDetail] = coordinator
        coordinator.start()
    }
}
