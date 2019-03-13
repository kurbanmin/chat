//
//  GCDDataManager.swift
//  Chat
//
//  Created by Qurban on 13/03/2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

class GCDDataManager: DataManagerProtocol {
    func loadProfile(completion: @escaping (Profile?) ->()) {
        DispatchQueue.global().async {
            guard let directoryURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            let fileURL = directoryURL.appendingPathComponent("profile.json")
            
            guard let data = try? Data(contentsOf: fileURL) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            if let profile = try? JSONDecoder().decode(Profile.self, from: data) {
                DispatchQueue.main.async {
                    completion(profile)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func save(profile: Profile, completion: @escaping (Bool) -> ()) {
        DispatchQueue.global().async {
            guard let directoryURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
                
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            
            let fileURL = directoryURL.appendingPathComponent("profile.json")
            
            guard let data = try? JSONEncoder().encode(profile) else {
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            
            do {
                try data.write(to: fileURL)
                DispatchQueue.main.async {
                    completion(true)
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
}
