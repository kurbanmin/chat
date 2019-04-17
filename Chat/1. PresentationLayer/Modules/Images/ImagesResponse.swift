//
//  NetworkJson.swift
//  Chat
//
//  Created by Qurban on 12.04.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

struct Hit: Codable {
    let webformatURL: String
}

struct ImagesResponse: Codable {
    var hits: [Hit]
}
