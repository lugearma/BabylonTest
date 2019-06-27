//
//  PersistentManager.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/27/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation
import CoreData

protocol PersistentManagerProtocol {
    var persistentContainer: NSPersistentContainer { get }
    init(container: NSPersistentContainer)
    
    func fetchData<T: NSManagedObject>(request: NSFetchRequest<T>) -> Result<[T], Error>
}

class PersistentManager: PersistentManagerProtocol {
    
    let persistentContainer: NSPersistentContainer
    
    required init(container: NSPersistentContainer) {
        self.persistentContainer = container
    }
    
    func fetchData<T>(request: NSFetchRequest<T>) -> Result<[T], Error> {
        do {
            let data = try persistentContainer.viewContext.fetch(request)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    func saveData(_ data: [Post]) {
        for post in data {
            let newPost = NSEntityDescription.insertNewObject(forEntityName: "ManagedPost", into: self.persistentContainer.viewContext) as! ManagedPost
            newPost.body = post.body
            newPost.title = post.title
            newPost.id = Int32(post.id)
            newPost.userId = Int32(post.userId)
        }
        
        do {
            try self.persistentContainer.viewContext.save()
        } catch {
            // TODO: What do i have to do here?
        }
    }
}
