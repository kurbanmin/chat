//
//  AppUser+CoreDataProperties.swift
//  
//
//  Created by Qurban on 31.03.2019.
//
//

import Foundation
import CoreData

extension AppUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppUser> {
        return NSFetchRequest<AppUser>(entityName: "AppUser")
    }

    @NSManaged public var conversations: Conversation?
    @NSManaged public var currentUser: User?

}
