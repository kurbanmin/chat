//
//  Conversations.swift
//  Chat
//
//  Created by Qurban on 22.02.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

struct Conversation {
    let name: String
    let messages: [Message]
    let online: Bool
    let hasUnreadMessages: Bool
}

