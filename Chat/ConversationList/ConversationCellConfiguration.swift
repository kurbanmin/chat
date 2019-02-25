//
//  ProtocolFile.swift
//  Chat
//
//  Created by Qurban on 24.02.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

protocol ConversationCellConfiguration: class {
    var name: String? { get set }
    var message: String? { get set }
    var date: Date? { get set }
    var online: Bool { get set }
    var hasUnreadMessages: Bool { get set }
}
