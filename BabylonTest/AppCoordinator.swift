//
//  AppCoordinator.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/18/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit

enum CoodinatorFlow {
    case posts
}

protocol CoordinatorProtocol {
    func start()
}

final class AppCoordinator: CoordinatorProtocol {
    
    let window: UIWindow
    let apiClient: APIClientProtocol
    let persistentManager: PersistentManager
    let persistentClient: PersistentClientProtocol
    var coordinators: [CoodinatorFlow : CoordinatorProtocol] = [:]
    let navigationController = UINavigationController()
    
    init(window: UIWindow, apiClient: APIClientProtocol, persistentManager: PersistentManager) {
        self.window = window
        self.apiClient = apiClient
        self.persistentManager = persistentManager
        self.persistentClient = PersistentClient(persistentManager: persistentManager)
    }
    
    func start() {
        startPosts()
        navigationController.navigationBar.prefersLargeTitles = true
        window.rootViewController = navigationController
    }
}

// MARK: - PostsCoordinatorDelegate

extension AppCoordinator: PostsCoordinatorDelegate {
    
    private func startPosts() {
        let postsCoordinator = PostsCoordinator(navigationController: navigationController, apiClient: apiClient, persistentClient: persistentClient)
        postsCoordinator.delegate = self
        coordinators[.posts] = postsCoordinator
        postsCoordinator.start()
    }
}
