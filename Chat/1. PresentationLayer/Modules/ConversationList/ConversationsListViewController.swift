//
//  ConversationsListViewController.swift
//  Chat
//
//  Created by Qurban on 22.02.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController, IConversationModelDelegate {
    var dataSource: ConversationsListDataSource!
    var conversationObject: ConversationObject!

    var conversationsListModel: IConversationsListModel?
    var presentationAssembly: IPresentationAssembly?

    func configure(conversationsListModel: ConversationsListModel, presentationAssembly: PresentationAssembly) {
        self.presentationAssembly = presentationAssembly
        self.conversationsListModel = conversationsListModel
    }

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

    @IBAction func profileAction(_ sender: UIBarButtonItem) {
        if let profileNC = presentationAssembly?.profileNC() {
            self.present(profileNC, animated: true, completion: nil)
        }
    }

    func show(error message: String) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Tinkoff Chat"

        dataSource = ConversationsListDataSource(tableView: tableView)
        dataSource.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

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
    func showConversation(conversationObject: ConversationObject) {
        if let conversationVC = presentationAssembly?.conversationVC(conversationObject: conversationObject) {
            self.navigationController?.pushViewController(conversationVC, animated: true)
        }
    }
}
