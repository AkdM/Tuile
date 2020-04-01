//
//  Window+CoreDataProperties.swift
//  Tuile
//
//  Created by Anthony Da Mota on 01/04/2020.
//  Copyright © 2020 Anthony Da Mota. All rights reserved.
//
//

import Foundation
import CoreData


extension Window {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Window> {
        return NSFetchRequest<Window>(entityName: "Window")
    }

    @NSManaged public var tabs: NSSet?

}

// MARK: Generated accessors for tabs
extension Window {

    @objc(addTabsObject:)
    @NSManaged public func addToTabs(_ value: Tab)

    @objc(removeTabsObject:)
    @NSManaged public func removeFromTabs(_ value: Tab)

    @objc(addTabs:)
    @NSManaged public func addToTabs(_ values: NSSet)

    @objc(removeTabs:)
    @NSManaged public func removeFromTabs(_ values: NSSet)

}
