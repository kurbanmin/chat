//
//  CommunicationMessage.swift
//  Chat
//
//  Created by Qurban on 19/03/2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

struct CommunicationMessage: Codable {
    let eventType: String
    let text: String
    let messageId: String

    init(text: String) {
        self.eventType = "TextMessage"
        self.messageId = CommunicationMessage.generateMessageId()
        self.text = text
    }

    static func generateMessageId() -> String {
        return "\(arc4random_uniform(UINT32_MAX))+\(Date.timeIntervalSinceReferenceDate)"
            .data(using: .utf8)!.base64EncodedString()
    }
}
