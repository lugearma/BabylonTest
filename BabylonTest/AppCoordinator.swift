//
//  AppCoordinator.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/18/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit

enum Coodinator {
    case posts
}

protocol CoordinatorProtocol {
    func start()
}

final class AppCoordinator: CoordinatorProtocol {
    
    let window: UIWindow
    let apiClient: APIClientProtocol
    var coordinators: [Coodinator : CoordinatorProtocol] = [:]
    let navigationController = UINavigationController()
    
    init(window: UIWindow, apiClient: APIClientProtocol) {
        self.window = window
        self.apiClient = apiClient
    }
    
    func start() {
        startPosts()
        window.rootViewController = navigationController
    }
}

// MARK: - PostsCoordinatorDelegate

extension AppCoordinator: PostsCoordinatorDelegate {
    
    func presentPost(for id: String) {
        
    }
    
    private func startPosts() {
        let postsCoordinator = PostsCoordinator(navigationController: navigationController, apiClient: apiClient)
        postsCoordinator.delegate = self
        coordinators[.posts] = postsCoordinator
        postsCoordinator.start()
    }
}
