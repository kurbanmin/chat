//
//  ConversationViewController.swift
//  Chat
//
//  Created by Qurban on 25.02.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var conversation: Conversation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = conversation.name
        tableView.dataSource = self
    }
}

extension ConversationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversation.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = conversation.messages[indexPath.row]
        let identifier = message.incoming ? "InputMessageCell" : "OutputMessageCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MessageCell
        cell.messageText = message.text
        
        return cell
    }
}
