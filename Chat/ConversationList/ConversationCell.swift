//
//  ConversationsCell.swift
//  Chat
//
//  Created by Qurban on 22.02.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell, ConversationCellConfiguration  {
    
    var name: String? {
        didSet {
            nameLabel.text = name 
        }
    }
    
    var message: String? {
        didSet {
            if let message = message {
                messageLabel.text = message
                messageLabel.font = UIFont.systemFont(ofSize: 14)
            } else {
                messageLabel.text = "No messages yet"
                messageLabel.font = UIFont.italicSystemFont(ofSize: 14)
            }
        }
    }
    
    var date: Date? {
        didSet {
            guard let date = date else {
                dateLabel.text = ""
                return
            }
            
            let dateFormatter = DateFormatter()
            
            if Calendar.current.isDateInToday(date) {
                dateFormatter.dateFormat = "HH:mm"
            } else {
                dateFormatter.dateFormat = "dd MMM"
            }
            
            dateLabel.text = dateFormatter.string(from: date)
        }
    }
    
    var online: Bool = false {
        didSet {
            if online {
                backgroundColor = UIColor(red: 255 / 255, green: 253 / 255, blue: 180 / 255, alpha: 1)
            } else {
                backgroundColor = .white
            }
        }
    }
    
    var hasUnreadMessages: Bool = false {
        didSet {
            if hasUnreadMessages {
                messageLabel.font = UIFont.boldSystemFont(ofSize: 14)
            }
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!    
}
