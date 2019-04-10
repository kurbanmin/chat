//
//  ProfileService.swift
//  Chat
//
//  Created by Qurban on 09.04.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

protocol IProfileService {
    func getProfile(completionHandler: @escaping (Profile?) -> Void)
    func save(profile: Profile, completionHandler: (() -> Void)?)
}

class ProfileService: IProfileService {
    var storageManager: IStorageManager

    init(storageManager: IStorageManager) {
        self.storageManager = storageManager
    }

    func getProfile(completionHandler: @escaping (Profile?) -> Void) {
        storageManager.getProfile(completionHandler: completionHandler)
    }

    func save(profile: Profile, completionHandler: (() -> Void)?) {
        storageManager.save(profile: profile, completionHandler: completionHandler)
    }
}
