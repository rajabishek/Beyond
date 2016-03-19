//
//  Note.swift
//  Beyond
//
//  Created by Raj Abishek on 19/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import Foundation
import CoreData

class Note:NSManagedObject {
    
    @NSManaged var title: String
    @NSManaged var content: String
}
