//
//  ConversationUser.swift
//  Chat
//
//  Created by Qurban on 19/03/2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class ConversationUser {
    var peerID: MCPeerID
    var userName: String

    init(peerID: MCPeerID, userName: String) {
        self.peerID = peerID
        self.userName = userName
    }
}
