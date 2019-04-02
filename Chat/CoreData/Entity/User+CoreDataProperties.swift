//
//  User+CoreDataProperties.swift
//  Chat
//
//  Created by Qurban on 26.03.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//
//

import Foundation
import CoreData

extension User {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var isOnline: Bool
    @NSManaged public var name: String?
    @NSManaged public var userID: String?
    @NSManaged public var imageData: NSData?
    @NSManaged public var about: String?
    @NSManaged public var appUser: AppUser?
    @NSManaged public var conversation: Conversation?
}
