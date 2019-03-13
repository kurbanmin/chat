//
//  LoadOperation.swift
//  Chat
//
//  Created by Qurban on 13/03/2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

class LoadOperation: AsyncOperation {
    var profile: Profile?
    
    override func main() {
        loadProfile { [weak self] profile in
            self?.profile = profile
            self?.state = .finished
        }
    }
    
    func loadProfile(completion: @escaping (Profile?) ->()) {
        guard let directoryURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
            completion(nil)
            return
        }
        
        let fileURL = directoryURL.appendingPathComponent("profile.json")
        
        guard let data = try? Data(contentsOf: fileURL) else {
            completion(nil)
            return
        }
        
        if let profile = try? JSONDecoder().decode(Profile.self, from: data) {
            completion(profile)
        } else {
            completion(nil)
        }
    }
}
