//
//  Session+CoreDataProperties.swift
//  Tuile
//
//  Created by Anthony Da Mota on 31/03/2020.
//  Copyright © 2020 Anthony Da Mota. All rights reserved.
//
//

import Foundation
import CoreData


extension Session {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Session> {
        return NSFetchRequest<Session>(entityName: "Session")
    }

    @NSManaged public var created: Date?
    @NSManaged public var title: String?

}
