//
//  PostCoordinator.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/23/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit

protocol PostsCoordinatorDelegate: AnyObject {
    func presentPost(for id: String)
}

class PostsCoordinator: CoordinatorProtocol {
    
    private var apiClient: APIClientProtocol
    private var navigationController: UINavigationController
    weak var delegate: PostsCoordinatorDelegate?
    lazy var postsController: PostsViewController = configureController()
    
    init(navigationController: UINavigationController, apiClient: APIClientProtocol) {
        self.navigationController = navigationController
        self.apiClient = apiClient
    }
    
    func start() {
        navigationController.pushViewController(postsController, animated: true)
    }
    
    private func configureController() -> PostsViewController {
        let postRespository = PostRepository(apiClient: apiClient)
        let viewModel = PostsViewModel(repository: postRespository)
        viewModel.coordinatorDelegate = self
        let postsViewController = PostsViewController(viewModel: viewModel)
        return postsViewController
    }
}

// MARK: - PostsViewModelCoodinatorDelegate

extension PostsCoordinator: PostsViewModelCoodinatorDelegate {
    
    func presentPost(for id: String) {
        delegate?.presentPost(for: id)
    }
}
