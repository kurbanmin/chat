//
//  ConversationsListViewController.swift
//  Chat
//
//  Created by Qurban on 22.02.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController {
    var communicationManager = CommunicationManager.shared

    var dataSource: ConversationsListDataSource!

    var conversationModel: ConversationModel!

    let closure: (UIColor) -> Void = { selectedTheme in
        DispatchQueue.global().async {
            Logger.logThemeChanging(selectedTheme: selectedTheme)
            let colorData = NSKeyedArchiver.archivedData(withRootObject: selectedTheme)
            UserDefaults.standard.set(colorData, forKey: "Theme")

            DispatchQueue.main.async {
                UINavigationBar.appearance().barTintColor = selectedTheme
            }
        }
    }

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Tinkoff Chat"

        dataSource = ConversationsListDataSource(tableView: tableView)
        dataSource.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let conversationVC = segue.destination as? ConversationViewController {
            conversationVC.conversationModel = conversationModel
        }

        if segue.identifier == "ShowThemesViewController" {
            if let navigationController = segue.destination as? UINavigationController,
                let themesVC = navigationController.topViewController as? ThemesViewController {

                let model = Themes()
                model.theme1 = .blue
                model.theme2 = .black
                model.theme3 = .purple

                themesVC.model = model
                themesVC.closure = closure
            }
        }
    }
}

extension ConversationsListViewController: ConversationsListDataSourceDelegate {
    func showConversation(conversationModel: ConversationModel) {
        self.conversationModel = conversationModel
        performSegue(withIdentifier: "ShowConversation", sender: nil)
    }
}
