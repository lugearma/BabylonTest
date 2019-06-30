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
    func insertNewData<T: NSManagedObject>(for entityName: String, objectHandler: @escaping (T) -> Void)
    func commitChanges()
}

extension PersistentManagerProtocol {
    func commitChanges() {
        guard persistentContainer.viewContext.hasChanges else { return }
        do {
            try persistentContainer.viewContext.save()
        } catch { }
    }
}

class PersistentManager: PersistentManagerProtocol {
    
    let persistentContainer: NSPersistentContainer
    
    required init(container: NSPersistentContainer) {
        self.persistentContainer = container
    }
    
    func fetchData<T>(request: NSFetchRequest<T>) -> Result<[T], Error> {
        do {
            let data = try self.persistentContainer.viewContext.fetch(request)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    func insertNewData<T: NSManagedObject>(for entityName: String, objectHandler: @escaping (T) -> Void) {
        guard let object = NSEntityDescription.insertNewObject(forEntityName: entityName, into: persistentContainer.viewContext) as? T else {
            return
        }
        objectHandler(object)
    }
}
