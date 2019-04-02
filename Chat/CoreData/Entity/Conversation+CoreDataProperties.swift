//
//  Conversation+CoreDataProperties.swift
//  
//
//  Created by Qurban on 31.03.2019.
//
//

import Foundation
import CoreData

extension Conversation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Conversation> {
        return NSFetchRequest<Conversation>(entityName: "Conversation")
    }

    @NSManaged public var conversationID: String?
    @NSManaged public var hasUnreadMessages: Bool
    @NSManaged public var isOnline: Bool
    @NSManaged public var appUser: AppUser?
    @NSManaged public var messages: NSSet?
    @NSManaged public var participant: User?
    @NSManaged public var lastMessage: Message?

}

// MARK: Generated accessors for messages
extension Conversation {

    @objc(addMessagesObject:)
    @NSManaged public func addToMessages(_ value: Message)

    @objc(removeMessagesObject:)
    @NSManaged public func removeFromMessages(_ value: Message)

    @objc(addMessages:)
    @NSManaged public func addToMessages(_ values: NSSet)

    @objc(removeMessages:)
    @NSManaged public func removeFromMessages(_ values: NSSet)

}
