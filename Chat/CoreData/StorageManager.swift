//
//  StorageManager.swift
//  Chat
//
//  Created by Qurban on 25.03.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation
import CoreData
class StorageManager  {
    static var shared = StorageManager()
    
    let coreDataStack = CoreDataStack()
    
    var masterContext: NSManagedObjectContext {
        return coreDataStack.masterContext
    }
    
    func getProfile(completionHandler: @escaping (Profile?) -> ())  {
        masterContext.perform { [unowned self] in
            let appUser = AppUser.findOrInsertAppUser(in: self.masterContext)
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
    
    func save(profile: Profile, completionHandler: (() ->())?) {
        masterContext.perform { [unowned self] in
            let appUser = AppUser.findOrInsertAppUser(in: self.masterContext)
            let currentUser = appUser?.currentUser
            
            if let name = profile.name {
                currentUser?.name = name
            } else {
                currentUser?.name = ""
            }
            
            currentUser?.about = profile.description
            currentUser?.imageData = profile.image?.pngData() as NSData?
            
            self.coreDataStack.performSave(with: self.masterContext, completion: completionHandler)
        }
    }
    
    func updateUser(with userID: String, userName: String?, isOnline: Bool, completionHandler:(() -> ())?) {
        masterContext.perform { [unowned self] in
            if let user = User.findOrInsertUser(with: userID, in: self.masterContext) {
                if let name = userName {
                    user.name = name
                }
                user.isOnline = isOnline
            }
            
            self.coreDataStack.performSave(with: self.masterContext, completion: completionHandler)
        }
    }
    
    func getUsers(completionHandler:@escaping ([User], [User]) -> ()) {
        masterContext.perform { [unowned self] in
            let onlineUsers = User.getOnlineUsers(online: true, context: self.masterContext)
            let offlineUsers = User.getOnlineUsers(online: false, context: self.masterContext)
            completionHandler(onlineUsers, offlineUsers)
        }
    }
}
