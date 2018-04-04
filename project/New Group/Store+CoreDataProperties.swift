//
//  Store+CoreDataProperties.swift
//  project
//
//  Created by Student on 2018-04-03.
//  Copyright © 2018 Student. All rights reserved.
//
//

import Foundation
import CoreData


extension Store {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Store> {
        return NSFetchRequest<Store>(entityName: "Store")
    }

    @NSManaged public var locName: String?
    @NSManaged public var loc: String?
    @NSManaged public var longitudeLoc: Double
    @NSManaged public var latitudeLoc: Double
    @NSManaged public var imagePick: String?
    @NSManaged public var dateVisit: NSDate?

}
