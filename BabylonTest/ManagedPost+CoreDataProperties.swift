//
//  ManagedPost+CoreDataProperties.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/29/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//
//

import Foundation
import CoreData


extension ManagedPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedPost> {
        return NSFetchRequest<ManagedPost>(entityName: "ManagedPost")
    }

    @NSManaged public var body: String?
    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var userId: Int32

}
