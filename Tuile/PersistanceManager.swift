//
//  PersistanceManager.swift
//  Tuile
//
//  Created by Anthony Da Mota on 31/03/2020.
//  Copyright © 2020 Anthony Da Mota. All rights reserved.
//

import Foundation
import CoreData

final class PersistanceManager {
    
    static let shared = PersistanceManager()
    private init() { }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: SharedPersistantContainer = {
        let container = SharedPersistantContainer(name: "TuileModel")
        container.loadPersistentStores { (storeDescription, err) in
            if let error = err as NSError? {
                fatalError("Unresolved error: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    lazy var context = persistentContainer.viewContext
    
    // MARK: - Core Data saving function

    func save() {
        if context.hasChanges {
            do {
                try context.save()
                print("Saved")
            } catch {
                let err = error as NSError
                fatalError("Unresolved error while saving: \(err), \(err.userInfo)")
            }
        }
    }
    
    func delete<T: NSManagedObject>(_ objectType: T.Type, persist: Bool = true) -> Bool {
        let entity = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        do {
            let result = try? context.fetch(fetchRequest) as? [T]
            for object in (result ?? [T]()) {
                print("Deleted.")
                context.delete(object)
            }
        } catch {
            print("Deletion error: \(error)")
            return false
        }
        
        if persist {
            self.save()
        }
        return true
    }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entity = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        } catch {
            print("Fetch error:\(error)")
            return [T]()
        }
    }
}

class SharedPersistantContainer: NSPersistentContainer {
    static let sharedUrl = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.akdm.sharedData")!
    let storeDescription = NSPersistentStoreDescription(url: sharedUrl)
    
    override class func defaultDirectoryURL() -> URL {
        return sharedUrl
    }
} 
