//
//  Tab+CoreDataProperties.swift
//  Tuile
//
//  Created by Anthony Da Mota on 01/04/2020.
//  Copyright © 2020 Anthony Da Mota. All rights reserved.
//
//

import Foundation
import CoreData


extension Tab {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tab> {
        return NSFetchRequest<Tab>(entityName: "Tab")
    }

    @NSManaged public var title: String?
    @NSManaged public var url: URL?
    @NSManaged public var isPrivate: Bool

}
