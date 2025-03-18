//
//  SavedPost+CoreDataProperties.swift
//  NewsFeed
//
//  Created by Ксения Маричева on 10.03.2025.
//
//

import Foundation
import CoreData


extension SavedPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedPost> {
        return NSFetchRequest<SavedPost>(entityName: "SavedPost")
    }

    @NSManaged public var title: String?
    @NSManaged public var avatar: Data?
    @NSManaged public var text: String?
    @NSManaged public var id: Int32

}

extension SavedPost : Identifiable {

}
