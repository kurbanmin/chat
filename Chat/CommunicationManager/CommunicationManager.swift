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

    var multipeerCommunicator: Communicator!
    var conversations = [Conversation]()

    init() {
        multipeerCommunicator = MultipeerCommunicator()
        multipeerCommunicator.delegate = self
    }

    func sendMessage(text: String, to userID: String) {
        multipeerCommunicator.sendMessage(string: text, to: userID) { [unowned self] (success, _) in
            if success {
                self.storageManager.appendMessageToConversation(conversationID: userID, text: text, isIncoming: false)
            }
        }
    }

    func didFoundUser(userID: String, userName: String?) {
        storageManager.updateUser(with: userID,
                                  userName: userName,
                                  isOnline: true,
                                  completionHandler: nil)
    }

    func didLostUser(userID: String) {
        storageManager.updateUser(with: userID,
                                  userName: nil,
                                  isOnline: false,
                                  completionHandler: nil)
    }

    func failedToStartBrowsing(error: Error) {

    }

    func failedToStartAdvertising(error: Error) {

    }

    func didRecieveMessage(text: String, fromUser: String, to user: String) {
        storageManager.appendMessageToConversation(conversationID: fromUser, text: text, isIncoming: true)
    }
}
