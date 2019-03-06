//
//  ConversationsListViewController.swift
//  Chat
//
//  Created by Qurban on 22.02.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController {
    let conversationsSections = [
        ConversationSection(title: "Online", conversations: [
            Conversation(name: "Иван Иванов", messages: [Message(text: "Привет как дела?", incoming: true, date: Date().addingTimeInterval(-500000000)), Message(text: "Привет, хорошо", incoming: false, date: Date().addingTimeInterval(-200000000))], online: true, hasUnreadMessages: false),
            Conversation(name: "Иван Иванов", messages: [Message(text: "Привет как дела?", incoming: true, date: Date().addingTimeInterval(-500000000)), Message(text: "Привет, хорошо", incoming: false, date: Date().addingTimeInterval(-200000000))], online: true, hasUnreadMessages: false),
            Conversation(name: "Иван Иванов", messages: [Message(text: "Привет как дела?", incoming: true, date: Date().addingTimeInterval(-500)), Message(text: "Привет, хорошо", incoming: false, date: Date())], online: true, hasUnreadMessages: false),
            
            Conversation(name: "Иван Иванов", messages: [Message(text: "Привет как дела?", incoming: true, date: Date().addingTimeInterval(-500000000)), Message(text: "Привет, хорошо", incoming: false, date: Date().addingTimeInterval(-200000000))], online: true, hasUnreadMessages: false),
            Conversation(name: "Иван Иванов", messages: [Message(text: "Привет как дела?", incoming: true, date: Date().addingTimeInterval(-500)), Message(text: "Привет, хорошо", incoming: false, date: Date())], online: true, hasUnreadMessages: true),
            Conversation(name: "Иван Иванов", messages: [Message(text: "Привет как дела?", incoming: true, date: Date().addingTimeInterval(-500000000)), Message(text: "Привет, хорошо", incoming: false, date: Date().addingTimeInterval(-200000000))], online: true, hasUnreadMessages: false),
            Conversation(name: "Иван Иванов", messages: [Message(text: "Привет как дела?", incoming: true, date: Date().addingTimeInterval(-500000000)), Message(text: "Привет, хорошо", incoming: false, date: Date().addingTimeInterval(-200000000))], online: true, hasUnreadMessages: false),
            Conversation(name: "Иван Иванов", messages: [Message(text: "Привет как дела?", incoming: true, date: Date().addingTimeInterval(-500)), Message(text: "Привет, хорошо", incoming: false, date: Date())], online: true, hasUnreadMessages: false)
        ]),
        
        ConversationSection(title: "History", conversations: [
            Conversation(name: "Иван Иванов", messages: [Message(text: "Привет как дела?", incoming: true, date: Date().addingTimeInterval(-500)), Message(text: "Привет, хорошо", incoming: false, date: Date())], online: false, hasUnreadMessages: false),
            Conversation(name: "Иван Иванов", messages: [Message(text: "Привет как дела?", incoming: true, date: Date().addingTimeInterval(-500)), Message(text: "Привет, хорошо", incoming: false, date: Date())], online: false, hasUnreadMessages: false),
            Conversation(name: "Иван Иванов", messages: [Message(text: "Привет как дела?", incoming: true, date: Date().addingTimeInterval(-500)), Message(text: "Привет, хорошо", incoming: false, date: Date())], online: false, hasUnreadMessages: false),
            Conversation(name: "Иван Иванов", messages: [Message(text: "Привет как дела?", incoming: true, date: Date().addingTimeInterval(-500)), Message(text: "Привет, хорошо", incoming: false, date: Date())], online: false, hasUnreadMessages: false),
            Conversation(name: "Иван Иванов", messages: [Message(text: "Привет как дела?", incoming: true, date: Date().addingTimeInterval(-500)), Message(text: "Привет, хорошо", incoming: false, date: Date())], online: false, hasUnreadMessages: false)
        ])
    ]
    
    let closure: (UIColor) -> () = { selectedTheme in
        Logger.logThemeChanging(selectedTheme: selectedTheme)
        UINavigationBar.appearance().barTintColor = selectedTheme
        let colorData = NSKeyedArchiver.archivedData(withRootObject: selectedTheme)
        UserDefaults.standard.set(colorData, forKey: "Theme")
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Tinkoff Chat"
        
        tableView.register(UINib(nibName: "ConversationCell", bundle: Bundle.main), forCellReuseIdentifier: "ConversationCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let vc = segue.destination as? ConversationViewController, let indexPath = tableView.indexPathForSelectedRow {
            vc.conversation = conversationsSections[indexPath.section].conversations[indexPath.row]
        }
        
        // Swift
        if segue.identifier == "ShowThemesViewController" {
            if segue.identifier == "ShowThemesViewController" {
                if let nc = segue.destination as? UINavigationController, let vc = nc.topViewController as? ThemesViewController {
                    
                    let model = Themes()
                    model.theme1 = .blue
                    model.theme2 = .black
                    model.theme3 = .purple
                    
                    vc.model = model
                    vc.closure = closure
                }
            }
        }
        
        // Objective-c
//        if segue.identifier == "ShowThemesViewController" {
//            if let nc = segue.destination as? UINavigationController, let vc = nc.topViewController as? ThemesViewController {
//
//                let model = Themes()
//                model.theme1 = .blue
//                model.theme2 = .black
//                model.theme3 = .purple
//
//                vc.model = model
//                vc.delegate = self
//            }
//        }
    }
}

extension ConversationsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return conversationsSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversationsSections[section].conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as! ConversationCell
        let conversation = conversationsSections[indexPath.section].conversations[indexPath.row]
        
        cell.name = conversation.name
        cell.date = conversation.messages.last?.date
        cell.message = conversation.messages.last?.text
        cell.online = conversation.online
        cell.hasUnreadMessages = conversation.hasUnreadMessages
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return conversationsSections[section].title
    }
}

extension ConversationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowConversation", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//extension ConversationsListViewController: ThemesViewControllerDelegate {
//    func themesViewController(_ controller: ThemesViewController, didSelectTheme selectedTheme: UIColor) {
//        Logger.logThemeChanging(selectedTheme: selectedTheme)
//        UINavigationBar.appearance().barTintColor = selectedTheme
//
//        let colorData = NSKeyedArchiver.archivedData(withRootObject: selectedTheme)
//        UserDefaults.standard.set(colorData, forKey: "Theme")
//    }
//}


