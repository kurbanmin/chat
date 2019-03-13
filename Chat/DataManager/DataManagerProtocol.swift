//
//  DataManagerProtocol.swift
//  Chat
//
//  Created by Qurban on 13/03/2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

protocol DataManagerProtocol {
    func loadProfile(completion: @escaping (Profile?) ->())
    func save(profile: Profile, completion: @escaping (Bool) -> ())
}
