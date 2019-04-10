//
//  CommunicationManager.swift
//  Chat
//
//  Created by Qurban on 19/03/2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

protocol ICommunicationManager {
    var delegate: ICommunicationManagerDelegate? { get set }
    func sendMessage(text: String, to userID: String, completionHandler: ((_ succes: Bool, _ error: Error?) -> Void)?)
}

protocol ICommunicationManagerDelegate: class {
    func didFoundUser(userID: String, userName: String?)
    func didLostUser(userID: String)
    func didRecieveMessage(text: String, fromUser: String, to user: String)
}

class CommunicationManager: CommunicatorDelegate, ICommunicationManager {
    weak var delegate: ICommunicationManagerDelegate?

    var multipeerCommunicator: Communicator!
    var conversations = [Conversation]()

    init() {
        multipeerCommunicator = MultipeerCommunicator()
        multipeerCommunicator.delegate = self
    }

    func sendMessage(text: String, to userID: String, completionHandler: ((_ succes: Bool, _ error: Error?) -> Void)?) {
        multipeerCommunicator.sendMessage(string: text, to: userID, completionHandler: completionHandler)
    }

    func didFoundUser(userID: String, userName: String?) {
        delegate?.didFoundUser(userID: userID, userName: userName)
    }

    func didLostUser(userID: String) {
        delegate?.didLostUser(userID: userID)
    }

    func failedToStartBrowsing(error: Error) {

    }

    func failedToStartAdvertising(error: Error) {

    }

    func didRecieveMessage(text: String, fromUser: String, to user: String) {
        delegate?.didRecieveMessage(text: text, fromUser: fromUser, to: user)
    }
}
