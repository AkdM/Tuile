//
//  Session+CoreDataProperties.swift
//  Tuile
//
//  Created by Anthony Da Mota on 01/04/2020.
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
    @NSManaged public var windows: NSSet?

}

// MARK: Generated accessors for windows
extension Session {

    @objc(addWindowsObject:)
    @NSManaged public func addToWindows(_ value: Window)

    @objc(removeWindowsObject:)
    @NSManaged public func removeFromWindows(_ value: Window)

    @objc(addWindows:)
    @NSManaged public func addToWindows(_ values: NSSet)

    @objc(removeWindows:)
    @NSManaged public func removeFromWindows(_ values: NSSet)

}
