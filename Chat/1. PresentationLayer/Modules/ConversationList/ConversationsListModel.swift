//
//  ConversationsListModel.swift
//  Chat
//
//  Created by Qurban on 08.04.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

protocol IConversationsListModel {
    var delegate: IConversationModelDelegate? {get set}
}

protocol IConversationsListModelDelegate: class {
    func show(error message: String)
}

class ConversationsListModel: IConversationsListModel {
    weak var delegate: IConversationModelDelegate?
    var mcService: IMCService

    init(mcService: IMCService) {
        self.mcService = mcService
    }
}
