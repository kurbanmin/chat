//
//  Communicator.swift
//  Chat
//
//  Created by Qurban on 15/03/2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

protocol Communicator {
    func sendMessage(string: String, to userID: String, completionHandler: ((_ succes: Bool, _ error: Error?) -> ())?)
    var delegate: CommunicatorDelegate? {get set}
    var online: Bool {get set}
}
