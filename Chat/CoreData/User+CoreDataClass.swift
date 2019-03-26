//
//  User+CoreDataClass.swift
//  Chat
//
//  Created by Qurban on 24.03.2019.tt
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    
    static func insertUser(with userID: String, in context: NSManagedObjectContext) -> User? {
        guard let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as? User else { return nil }
        
        user.userID = userID
        
        return user
    }
    
    static func fetctRequestUser(with userID: String, model: NSManagedObjectModel) -> NSFetchRequest<User>? {
        let templateName = "UserWithID"
        
        guard let fetchRequest = model.fetchRequestFromTemplate(withName: templateName, substitutionVariables: ["userID": userID]) as? NSFetchRequest<User> else {
            assert(false, "No template witf name \(templateName)!")
            return nil
        }
        
        return fetchRequest
    }
    
    static func findOrInsertUser(with userID: String, in context: NSManagedObjectContext) -> User? {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print("Model is not availble in context!")
            assert(false)
            return nil
        }
        
        var user: User?
        
        guard let fetchRequest = User.fetctRequestUser(with: userID, model: model) else { return nil }
        
        do {
            let results = try context.fetch(fetchRequest)
            assert(results.count < 2, "Multiple AppUsers found!")
            if let foundUser = results.first {
                user = foundUser
            }
        } catch {
            print("Failed to fetch AppUser: \(error)")
        }
        
        if user == nil {
            user = User.insertUser(with: userID, in: context)
        }
        
        return user
    }
    
    static func getOnlineUsers(online: Bool, context: NSManagedObjectContext) -> [User] {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            assert(false)
            return []
        }
        
        guard let fetchRequest = User.fetctRequestOnlineUsers(online: online, model: model) else {
            return []
        }
        
        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            print(error)
        }
        
        return []
    }
    
    static func generateUserIdString() -> String {
        return "Kurban"
    }
    
    static func generateCurrentUserNameString() -> String {
        return "Kurban"
    }
    
    static func fetctRequestOnlineUsers(online: Bool, model: NSManagedObjectModel) -> NSFetchRequest<User>? {
        let templateName = "UsersOnline"
        
        guard let fetchRequest = model.fetchRequestFromTemplate(withName: templateName, substitutionVariables: ["isOnline": online]) as? NSFetchRequest<User> else {
            assert(false, "No template witf name \(templateName)!")
            return nil
        }
        
        return fetchRequest
    }
}
