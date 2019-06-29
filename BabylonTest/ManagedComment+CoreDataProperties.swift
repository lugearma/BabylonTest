//
//  ManagedComment+CoreDataProperties.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/29/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//
//

import Foundation
import CoreData


extension ManagedComment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedComment> {
        return NSFetchRequest<ManagedComment>(entityName: "ManagedComment")
    }

    @NSManaged public var postId: Int32
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var body: String?

}
