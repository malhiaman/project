//
//  Grocerystore+CoreDataProperties.swift
//  project
//
//  Created by Student on 2018-04-03.
//  Copyright © 2018 Student. All rights reserved.
//
//

import Foundation
import CoreData


extension Grocerystore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Grocerystore> {
        return NSFetchRequest<Grocerystore>(entityName: "Grocerystore")
    }

    @NSManaged public var nameStore: String?
    @NSManaged public var location: String?
    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    @NSManaged public var date: NSDate?
    @NSManaged public var pickImage: Int32

}
