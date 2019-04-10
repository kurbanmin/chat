//
//  MCServise.swift
//  Chat
//
//  Created by Qurban on 07.04.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

protocol IMCService {
    func sendMessage(text: String, to userID: String)
}

class MCServise: IMCService {
    var communicationManager: ICommunicationManager
    var storageManager: IStorageManager

    init(communicationManager: ICommunicationManager, storageManager: IStorageManager) {
        self.communicationManager = communicationManager
        self.storageManager = storageManager
        self.communicationManager.delegate = self
    }

    func sendMessage(text: String, to userID: String) {
        communicationManager.sendMessage(text: text, to: userID) { [unowned self] (success, _) in
            if success {
                self.storageManager.appendMessageToConversation(conversationID: userID, text: text, isIncoming: false)
            }
        }
    }
}

extension MCServise: ICommunicationManagerDelegate {
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

    func didRecieveMessage(text: String, fromUser: String, to user: String) {
        storageManager.appendMessageToConversation(conversationID: fromUser, text: text, isIncoming: true)
    }
}
