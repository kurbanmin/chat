//
//  ConversationModel.swift
//  Chat
//
//  Created by Qurban on 07.04.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

protocol IConversationModel {
    var delegate: IConversationModelDelegate? {get set}
    func sendMessage(text: String, to userID: String)
}

protocol IConversationModelDelegate: class {
    func show(error message: String)
}

class ConversationModel: IConversationModel {
    weak var delegate: IConversationModelDelegate?

    func sendMessage(text: String, to userID: String) {
        mcService.sendMessage(text: text, to: userID)
    }

    var mcService: IMCService

    init(mcService: IMCService) {
        self.mcService = mcService
    }
}
