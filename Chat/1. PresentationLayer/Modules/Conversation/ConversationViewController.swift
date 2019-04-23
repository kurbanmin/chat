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

    var titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = titleLabel
        titleLabel.text = conversationObject.userName
        titleLabel.textColor = .green
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
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

    func configure(conversationModel: ConversationModel, presentationAssembly: IPresentationAssembly) {
        self.conversationModel = conversationModel
        self.presentationAssembly = presentationAssembly
    }

    func show(error message: String) {
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

    func animateButton(enabled: Bool) {
        self.sendMessageButton.isEnabled = enabled
        UIView.animate(withDuration: 0.5, animations: {
            self.sendMessageButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        }, completion: { _ in
            self.sendMessageButton.transform = .identity
        })
    }

    func animateTitleLabel(isOnline: Bool) {
        if isOnline {
            UIView.animate(withDuration: 1) {
                self.titleLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.titleLabel.textColor = .green
            }
        } else {
            UIView.animate(withDuration: 1) {
                self.titleLabel.transform = .identity
                self.titleLabel.textColor = .black
            }
        }
    }
}

extension ConversationViewController: IConversationsListViewControllerDelegate {
    func didUpdateConversation(with userID: String, isOnline: Bool) {
        if conversationObject.conversationID == userID {
            animateTitleLabel(isOnline: isOnline)
            animateButton(enabled: isOnline)
        }
    }
}
