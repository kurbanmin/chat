//
//  ConversationViewController.swift
//  Chat
//
//  Created by Qurban on 25.02.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {
    
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var sendMessageButton: UIButton!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var conversation: Conversation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = conversation.name
        tableView.dataSource = self
        
        sendMessageButton.isEnabled = conversation.online
        conversation.hasUnreadMessages = false
       
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CommunicationManager.shared.delegate = self
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        let info = notification.userInfo!
        
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.bottomConstraint.constant = keyboardFrame.size.height
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        self.bottomConstraint.constant = 0
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        if let text = messageTextField.text, !text.isEmpty {
            CommunicationManager.shared.sendMessage(text: text, to: conversation.userID)
            messageTextField.text = ""
            tableView.reloadData()
        }
        
        messageTextField.resignFirstResponder()
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

extension ConversationViewController: CommunicationManagerDelegate {
    func didFoundUser(userID: String) {
        if conversation.userID == userID {
            DispatchQueue.main.async { [weak self] in
                self?.sendMessageButton.isEnabled = true
            }
        }
    }
    
    func didLostUser(userID: String) {
        if conversation.userID == userID {
            DispatchQueue.main.async { [weak self] in
                self?.sendMessageButton.isEnabled = false
            }
        }
    }
}
