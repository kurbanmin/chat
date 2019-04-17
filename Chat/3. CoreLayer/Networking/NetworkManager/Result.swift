//
//  Result.swift
//  Chat
//
//  Created by Qurban on 12.04.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

enum Result<T> {
    case succes(T)
    case error(String)
}
