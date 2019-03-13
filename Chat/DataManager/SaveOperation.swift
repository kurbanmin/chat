//
//  LoadOperation.swift
//  Chat
//
//  Created by Qurban on 13/03/2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

class SaveOperation: AsyncOperation {
    var profile: Profile
    var success: Bool?
    
    init(profile: Profile) {
        self.profile = profile
        super.init()
    }
    
    override func main() {
        save(profile: profile) { [weak self] success in
            self?.success = success
            self?.state = .finished
        }
    }
    
    func save(profile: Profile, completion: @escaping (Bool) -> ()) {
        guard let directoryURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
            completion(false)
            return
        }
        
        let fileURL = directoryURL.appendingPathComponent("profile.json")
        
        guard let data = try? JSONEncoder().encode(profile) else {
            completion(false)
            return
        }
        
        do {
            try data.write(to: fileURL)
            completion(true)
        } catch {
            completion(false)
        }
    }
}
