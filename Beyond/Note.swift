//
//  Note.swift
//  Beyond
//
//  Created by Raj Abishek on 19/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Note:NSManagedObject {
    
    @NSManaged var title: String
    @NSManaged var content: String
    
    static let entityName = "Note"
    
    class func createNoteAndSave(title: String, content: String) -> Bool {
        
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            let managedObjectContext = appDelegate.managedObjectContext
            if let note = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: managedObjectContext) as? Note {
                note.title = title
                note.content = content
                
                do {
                    try managedObjectContext.save()
                    return true
                } catch {
                    print(error)
                    return false
                }
            }
        }
        
        return false
    }
    
    class func getAllNotes() -> [Note]? {
        
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            let managedObjectContext = appDelegate.managedObjectContext
            let fetchRequest = NSFetchRequest(entityName: entityName)
        
            do {
                return try managedObjectContext.executeFetchRequest(fetchRequest) as? [Note]
            } catch {
                print(error)
            }
        }
        
        return nil
    }
    
    func save() -> Bool{
        
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            let managedObjectContext = appDelegate.managedObjectContext
            
            do {
                try managedObjectContext.save()
                return true
            } catch {
                print(error)
            }
        }
        
        return false
    }
    
    func remove() -> Bool {
        
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            let managedObjectContext = appDelegate.managedObjectContext
            managedObjectContext.deleteObject(self)
            do {
                try managedObjectContext.save()
                return true
            } catch {
                print(error)
            }
        }
        
        return false
    }
}
