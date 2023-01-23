//
//  Note.swift
//  VideoGameApp
//
//  Created by Mehmet Ali Demir on 19.01.2023.
//

import CoreData

@objc(Note)
class Note: NSManagedObject {
    @NSManaged var id: NSNumber!
    @NSManaged var title: String!
    @NSManaged var desc: String!
    @NSManaged var gameName: String!
    @NSManaged var deletedDate: Date?
}
