//
//  CoreData+Extension.swift
//  Rider
//
//  Created by Mac mini on 9/3/18.
//  Copyright © 2018 Mac mini. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    func saveToDatabase() {
        if self.hasChanges {
            do {
                try save()
                print("DataBase updated")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
    }
}
