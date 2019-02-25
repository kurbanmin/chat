//
//  MessageTableViewCell.swift
//  Chat
//
//  Created by Qurban on 25.02.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell, MessageCellConfiguration {
    
    var messageText: String? {
        didSet {
            messageLabel.text = messageText
        }
    }
    
    @IBOutlet weak var messageLabel: UILabel!
    
}
