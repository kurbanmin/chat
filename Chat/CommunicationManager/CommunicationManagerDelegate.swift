//
//  CommunicationManagerDelegate.swift
//  Chat
//
//  Created by Qurban on 19/03/2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

protocol CommunicationManagerDelegate: class {
    func setup(onlineConversations: [Conversation], offlineConversations: [Conversation])
    func didFoundUser(userID: String)
    func didLostUser(userID: String)
}

extension CommunicationManagerDelegate {
    // Optional methods
    func setup(onlineConversations: [Conversation], offlineConversations: [Conversation]) { }
    func didFoundUser(userID: String) { }
    func didLostUser(userID: String) { }
}
