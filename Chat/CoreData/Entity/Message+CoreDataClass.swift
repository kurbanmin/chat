//
//  Message+CoreDataClass.swift
//  
//
//  Created by Qurban on 31.03.2019.
//
//

import Foundation
import CoreData

@objc(Message)
public class Message: NSManagedObject {

    static func fetchRequestMessages(with conversationID: String,
                                     model: NSManagedObjectModel) -> NSFetchRequest<Message>? {
        let templateName = "MessagesWithConversationID"

        guard let fetchRequest = model.fetchRequestFromTemplate(
            withName: templateName,
            substitutionVariables: ["conversationID": conversationID]
            ) as? NSFetchRequest<Message> else {
            assert(false, "No template with name \(templateName)!")
            return nil
        }

        return fetchRequest
    }

}
