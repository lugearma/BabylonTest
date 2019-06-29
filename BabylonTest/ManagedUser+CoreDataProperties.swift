//
//  ManagedUser+CoreDataProperties.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/29/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//
//

import Foundation
import CoreData


extension ManagedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedUser> {
        return NSFetchRequest<ManagedUser>(entityName: "ManagedUser")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?

}
