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
    
    var storageManager = StorageManager.shared
    
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
        storageManager.getUsers { [unowned self] (onlineUsers, offlineUsers) in
            let onlineConversations = onlineUsers.map { Conversation(userID: $0.userID, name: $0.name, messages: [], online: $0.isOnline, hasUnreadMessages: false)  }
            let offlineConversations = offlineUsers.map { Conversation(userID: $0.userID, name: $0.name, messages: [], online: $0.isOnline, hasUnreadMessages: false)  }
            
            self.delegate?.setup(onlineConversations: onlineConversations, offlineConversations: offlineConversations)
        }
    }
    
    func didFoundUser(userID: String, userName: String) {
        storageManager.updateUser(with: userID, userName: userName, isOnline: true, completionHandler: { [unowned self] in
            self.delegate?.didFoundUser(userID: userID)
            self.updateData()
        })
        
    }
    
    func didLostUser(userID: String) {
        storageManager.updateUser(with: userID, userName: nil, isOnline: false, completionHandler: { [unowned self] in
            self.delegate?.didLostUser(userID: userID)
            self.updateData()
        })
        
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
