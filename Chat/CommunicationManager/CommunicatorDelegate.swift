//
//  CommunicatorDelegate.swift
//  Chat
//
//  Created by Qurban on 15/03/2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

protocol CommunicatorDelegate: class {
    func didFoundUser(userID: String, userName: String)
    func didLostUser(userID: String)
    
    func failedToStartBrowsing(error: Error)
    func failedToStartAdvertising(error: Error)
    
    func didRecieveMessage(text: String, fromUser: String, to user: String)
}
