//
//  StorageManager.swift
//  Chat
//
//  Created by Qurban on 25.03.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation
import CoreData

protocol IStorageManager {
    func getProfile(completionHandler: @escaping (Profile?) -> Void)
    func save(profile: Profile, completionHandler: (() -> Void)?)
    func updateUser(with userID: String, userName: String?, isOnline: Bool, completionHandler:(() -> Void)?)
    func appendMessageToConversation(conversationID: String, text: String, isIncoming: Bool)
}

class StorageManager: IStorageManager {
    static var shared = StorageManager()

    let coreDataStack = CoreDataStack()

    var model: NSManagedObjectModel {
        return coreDataStack.managedObjectModel
    }

    var saveContext: NSManagedObjectContext {
        return coreDataStack.saveContext
    }

    var mainContext: NSManagedObjectContext {
        return coreDataStack.mainContext
    }

    func getProfile(completionHandler: @escaping (Profile?) -> Void) {
        saveContext.perform { [unowned self] in
            let appUser = AppUser.findOrInsertAppUser(in: self.saveContext)
            let currentUser = appUser?.currentUser

            var image: UIImage?
            if let data = currentUser?.imageData {
                image = UIImage(data: data as Data)
            }

            let profile = Profile(name: currentUser?.name, description: currentUser?.about, image: image)

            DispatchQueue.main.async {
                completionHandler(profile)
            }
        }
    }

    func save(profile: Profile, completionHandler: (() -> Void)?) {
        saveContext.perform { [unowned self] in
            let appUser = AppUser.findOrInsertAppUser(in: self.saveContext)
            let currentUser = appUser?.currentUser

            if let name = profile.name {
                currentUser?.name = name
            } else {
                currentUser?.name = ""
            }

            currentUser?.about = profile.description
            currentUser?.imageData = profile.image?.pngData() as NSData?

            self.coreDataStack.performSave(with: self.saveContext, completion: completionHandler)
        }
    }

    func updateUser(with userID: String, userName: String?, isOnline: Bool, completionHandler:(() -> Void)?) {
        saveContext.perform { [unowned self] in
            if let user = User.findOrInsertUser(with: userID, in: self.saveContext) {
                if let name = userName {
                    user.name = name
                }
                user.isOnline = isOnline

                if let conversation = user.conversation {
                    conversation.isOnline = isOnline
                } else {
                    let conversation = Conversation(context: self.saveContext)
                    conversation.conversationID = user.userID
                    conversation.isOnline = isOnline
                    user.conversation = conversation
                }
            }
            self.coreDataStack.performSave(with: self.saveContext, completion: completionHandler)
        }
    }

    func appendMessageToConversation(conversationID: String, text: String, isIncoming: Bool) {
        saveContext.perform { [unowned self] in
            let conversation = Conversation.findConversation(with: conversationID, in: self.saveContext)
            let message = Message(context: self.saveContext)
            message.isIncoming = isIncoming
            message.date = Date() as NSDate
            message.text = text
            message.conversation = conversation

            if isIncoming {
                message.sender = User.findOrInsertUser(with: conversationID, in: self.saveContext)
                message.receiver = AppUser.findOrInsertAppUser(in: self.saveContext)?.currentUser
            } else {
                message.sender = AppUser.findOrInsertAppUser(in: self.saveContext)?.currentUser
                message.receiver = User.findOrInsertUser(with: conversationID, in: self.saveContext)
            }

            conversation?.addToMessages(message)
            conversation?.lastMessage = message

            self.coreDataStack.performSave(with: self.saveContext, completion: nil)
        }
    }

    func getUsers(completionHandler:@escaping ([User], [User]) -> Void) {
        saveContext.perform { [unowned self] in
            let onlineUsers = User.getUsers(online: true, context: self.saveContext)
            let offlineUsers = User.getUsers(online: false, context: self.saveContext)
            completionHandler(onlineUsers, offlineUsers)
        }
    }
}
