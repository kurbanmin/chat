//
//  Conversations.swift
//  Chat
//
//  Created by Qurban on 22.02.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

class Conversation {
    var userID: String
    var name: String
    var messages: [Message]
    var online: Bool
    var hasUnreadMessages: Bool
    
    init(userID: String, name: String, messages: [Message], online: Bool, hasUnreadMessages: Bool) {
        self.userID = userID
        self.name = name
        self.messages = messages
        self.online = online
        self.hasUnreadMessages = hasUnreadMessages
    }
}
