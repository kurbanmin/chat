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

    var conversationModel: ConversationModel!

    var dataSource: ConversationDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = conversationModel.userName

        if let conversationID = conversationModel.conversationID {
            dataSource = ConversationDataSource(conversationID: conversationID, tableView: tableView)
        }

//        sendMessageButton.isEnabled = conversation.isOnline
//        conversation.hasUnreadMessages = false

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(notification: Notification) {
        let info = notification.userInfo!

        guard let keyboardFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }

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
            if let conversationID = conversationModel.conversationID {
                CommunicationManager.shared.sendMessage(text: text, to: conversationID)
            }
            messageTextField.text = ""
            tableView.reloadData()
        }

        messageTextField.resignFirstResponder()
    }
}
