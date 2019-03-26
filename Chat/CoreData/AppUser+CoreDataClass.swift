//
//  AppUser+CoreDataClass.swift
//  Chat
//
//  Created by Qurban on 24.03.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//
//

import Foundation
import CoreData

@objc(AppUser)
public class AppUser: NSManagedObject {
    
    static func insertAppUser(in context: NSManagedObjectContext) -> AppUser? {
        guard let appUser = NSEntityDescription.insertNewObject(forEntityName: "AppUser", into: context) as? AppUser else { return nil }
        
        let currentUser = User.insertUser(with: User.generateUserIdString(), in: context)
        currentUser?.name = User.generateCurrentUserNameString()
        appUser.currentUser = currentUser
        
        return appUser
    }
    
    static func fetchRequestAppUser(model: NSManagedObjectModel) -> NSFetchRequest<AppUser>? {
        let  templateName = "AppUser"
        
        guard let fetchRequest = model.fetchRequestTemplate(forName: templateName) as? NSFetchRequest<AppUser> else {
            assert(false, "No template with name \(templateName)!")
            return nil
        }
        
        return fetchRequest
    }
    
    static func findOrInsertAppUser(in context: NSManagedObjectContext) -> AppUser? {
        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
            print("Model is not available in context!")
            assert(false)
            return nil
        }
        
        var appUser: AppUser?
        
        guard let fetchRequest = AppUser.fetchRequestAppUser(model: model) else { return nil}
        
        do {
            let results = try context.fetch(fetchRequest)
            assert(results.count < 2, "Multupie AppUsers found!")
            if let foundUser = results.first {
                appUser = foundUser
            }
        } catch {
            print("Failed to fetch AppUser: \(error)")
        }
        
        if appUser == nil {
            appUser = AppUser.insertAppUser(in: context)
        }
        
        return appUser
    }
}
