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
    func insertNewData(for entityName: String, objectHandler: @escaping ((NSManagedObject) -> Void))
    func commitChanges()
}

extension PersistentManagerProtocol {
    func commitChanges() {
        do {
            guard persistentContainer.viewContext.hasChanges else { return }
            try persistentContainer.viewContext.save()
        } catch {
            // TODO: What do i have to do here?
        }
    }
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
    
    func insertNewData(for entityName: String, objectHandler: @escaping (NSManagedObject) -> Void) {
        let object = NSEntityDescription.insertNewObject(forEntityName: entityName, into: persistentContainer.viewContext)
        objectHandler(object)
    }
}
