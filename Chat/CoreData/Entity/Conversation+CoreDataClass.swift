//
//  Conversation+CoreDataClass.swift
//  
//
//  Created by Qurban on 31.03.2019.
//
//

import Foundation
import CoreData

@objc(Conversation)
public class Conversation: NSManagedObject {

    static func fetchRequestConversation(with conversationID: String,
                                         model: NSManagedObjectModel) -> NSFetchRequest<Conversation>? {
        let templateName = "ConversationWithID"

        guard let fetchRequest = model.fetchRequestFromTemplate(
            withName: templateName,
            substitutionVariables: ["conversationID": conversationID]
            ) as? NSFetchRequest<Conversation> else {
            assert(false, "No template witf name \(templateName)!")
            return nil
        }

        return fetchRequest
    }

    static func findConversation(with conversationID: String, in context: NSManagedObjectContext) -> Conversation? {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print("Model is not availble in context!")
            assert(false)
            return nil
        }

        var conversation: Conversation?

        guard let fetchRequest = Conversation.fetchRequestConversation(
            with: conversationID,
            model: model)
        else { return nil }

        do {
            let results = try context.fetch(fetchRequest)
            assert(results.count < 2, "Multiple AppUsers found!")
            if let foundConversation = results.first {
                conversation = foundConversation
            }
        } catch {
            print("Failed to fetch AppUser: \(error)")
        }

        return conversation
    }

    static func fetchRequestConversationsWithOnlineUsers(model: NSManagedObjectModel) -> NSFetchRequest<Conversation>? {
        let templateName = "ConversationsWithOnlineUsers"

        guard let fetchRequest = model.fetchRequestFromTemplate(
            withName: templateName,
            substitutionVariables: ["isOnline": true]
            ) as? NSFetchRequest<Conversation> else {
            assert(false, "No template witf name \(templateName)!")
            return nil
        }

        return fetchRequest
    }
}
