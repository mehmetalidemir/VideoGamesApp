//
//  GameFavorite.swift
//  VideoGameApp
//
//  Created by Mehmet Ali Demir on 22.01.2023.
//

import CoreData

@objc(GameFavorite)
class GameFavorite: NSManagedObject {
    @NSManaged var id: NSNumber!
    @NSManaged var name: String!
    @NSManaged var background_image: String!
}
