//
//  CoreDataManager.swift
//  PuzzleGame
//
//  Created by Consultant on 11/30/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    //CoreData Stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PuzzleGame")
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if let error = error as NSError?{
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var mainMOC: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    //MARK: Coredata saving
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
}
