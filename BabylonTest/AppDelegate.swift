//
//  AppDelegate.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/15/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: CoordinatorProtocol?
    let apiClient = APIClient()
    var persistentManager: PersistentManager?
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BabylonTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { preconditionFailure("Unexpected failure, invalid value for window  ") }
        persistentManager = PersistentManager(container: persistentContainer)
        coordinator = AppCoordinator(window: window, apiClient: apiClient, persistentManager: persistentManager!)
        coordinator?.start()
        window.makeKeyAndVisible()
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        persistentManager?.commitChanges()
    }
}

