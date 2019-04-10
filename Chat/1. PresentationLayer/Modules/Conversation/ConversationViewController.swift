//
//  ConversationViewController.swift
//  Chat
//
//  Created by Qurban on 25.02.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, IConversationModelDelegate {
    @IBOutlet var bottomConstraint: NSLayoutConstraint!

    @IBOutlet var sendMessageButton: UIButton!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    var conversationObject: ConversationObject!
    var conversationModel: ConversationModel?

    var presentationAssembly: IPresentationAssembly?
    private var dataSource: ConversationDataSource!
    var presentation: PresentationAssembly!
    func configure(conversationModel: ConversationModel, presentationAssembly: IPresentationAssembly) {
        self.conversationModel = conversationModel
        self.presentationAssembly = presentationAssembly

    }

    func show(error message: String) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = conversationObject.userName

        if let conversationID = conversationObject.conversationID {
            dataSource = ConversationDataSource(conversationID: conversationID, tableView: tableView)
        }

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
            if let conversationID = conversationObject.conversationID {
                conversationModel?.sendMessage(text: text, to: conversationID)
            }
            messageTextField.text = ""
        }

        messageTextField.resignFirstResponder()
    }
}
