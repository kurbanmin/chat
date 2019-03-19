//
//  CommunicationManager.swift
//  Chat
//
//  Created by Qurban on 19/03/2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

class CommunicationManager: CommunicatorDelegate {
    static var shared = CommunicationManager()
    
    weak var delegate: CommunicationManagerDelegate? {
        didSet {
            updateData()
        }
    }
    
    var multipeerCommunicator: Communicator!
    var conversations = [Conversation]()
    
    init() {
        multipeerCommunicator = MultipeerCommunicator()
        multipeerCommunicator.delegate = self
    }
    
    func sendMessage(text: String, to userID: String) {
        if let conversation = conversations.filter({ $0.userID == userID }).first {
            let message = Message(text: text, incoming: false, date: Date())
            conversation.messages.append(message)
        }
        
        updateData()
        
        multipeerCommunicator.sendMessage(string: text, to: userID, completionHandler: nil)
    }
    
    func updateData() {
        let onlineConversations = conversations.filter { $0.online }
        let offlineConversations = conversations.filter { !$0.online }
        
        self.delegate?.setup(onlineConversations: onlineConversations, offlineConversations: offlineConversations)
    }
    
    func didFoundUser(userID: String, userName: String) {
        if let conversation = conversations.filter({ $0.userID == userID }).first {
            conversation.online = true
        } else {
            let conversation = Conversation(userID: userID, name: userName, messages: [], online: true, hasUnreadMessages: false)
            conversations.append(conversation)
        }
        
        delegate?.didFoundUser(userID: userID)
        updateData()
    }
    
    func didLostUser(userID: String) {
        if let conversation = conversations.filter({ $0.userID == userID }).first {
            conversation.online = false
        }
        
        delegate?.didLostUser(userID: userID)
        updateData()
    }
    
    func failedToStartBrowsing(error: Error) {
        
    }
    
    func failedToStartAdvertising(error: Error) {
        
    }
    
    func didRecieveMessage(text: String, fromUser: String, to user: String) {
        if let conversation = conversations.filter({ $0.userID == fromUser }).first {
            let message = Message(text: text, incoming: true, date: Date())
            conversation.messages.append(message)
            conversation.hasUnreadMessages = true
        }
        
        updateData()
    }
}
