//
//  AppCoordinator.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/18/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

final class AppCoordinator: Coordinator {
    
    let window: UIWindow
    let apiClient: APIClietProtocol
    
    init(window: UIWindow, apiClient: APIClietProtocol) {
        self.window = window
        self.apiClient = apiClient
    }
    
    func start() {
        let postRespository = PostRepository(apiClient: apiClient)
        let viewModel = PostsViewModel(repository: postRespository)
        let postsViewController = PostsViewController(viewModel: viewModel)
        window.rootViewController = postsViewController
        window.makeKeyAndVisible()
    }
}
