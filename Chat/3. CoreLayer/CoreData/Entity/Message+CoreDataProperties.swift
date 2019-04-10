//
//  Message+CoreDataProperties.swift
//  
//
//  Created by Qurban on 31.03.2019.
//
//

import Foundation
import CoreData

extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var isIncoming: Bool
    @NSManaged public var conversation: Conversation?
    @NSManaged public var sender: User?
    @NSManaged public var receiver: User?
    @NSManaged public var lastMessage: Conversation?

}
