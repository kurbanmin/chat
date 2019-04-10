//
//  ConversationsListDataSource.swift
//  Chat
//
//  Created by Qurban on 31.03.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation
import CoreData

protocol ConversationsListDataSourceDelegate: class {
    func showConversation(conversationObject: ConversationObject)
}

class ConversationsListDataSource: NSObject {
    let storageManager = StorageManager.shared

    var tableView: UITableView

    var frc: NSFetchedResultsController<Conversation>!

    weak var delegate: ConversationsListDataSourceDelegate?

    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib(nibName: "ConversationCell",
                                 bundle: Bundle.main),
                           forCellReuseIdentifier: "ConversationCell")

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension

        guard let fetchRequest = Conversation.fetchRequestConversationsWithOnlineUsers(model: self.storageManager.model)
        else { return }

        let dateSortDescriptor = NSSortDescriptor(key: "lastMessage.date", ascending: true)
        let nameSortDescriptor = NSSortDescriptor(key: "participant.name", ascending: true)
        fetchRequest.sortDescriptors = [dateSortDescriptor, nameSortDescriptor]

        self.frc = NSFetchedResultsController<Conversation>(fetchRequest: fetchRequest,
                                                            managedObjectContext: storageManager.mainContext,
                                                            sectionNameKeyPath: nil,
                                                            cacheName: nil)

        frc.delegate = self
        do {
            try frc.performFetch()
        } catch {
            print(error)
        }
    }
}

extension ConversationsListDataSource: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = self.frc.sections else {
            fatalError("No sections in frc")
        }

        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell",
                                                       for: indexPath) as? ConversationCell
        else { return UITableViewCell()}

        let conversation = self.frc.object(at: indexPath)

        cell.name = conversation.participant?.name
        cell.date = conversation.lastMessage?.date as Date?
        cell.message = conversation.lastMessage?.text
        cell.online = conversation.isOnline
        cell.hasUnreadMessages = conversation.hasUnreadMessages

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Online"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let conversation = self.frc.object(at: indexPath)
        let conversationObject = ConversationObject(conversationID: conversation.conversationID,
                                                  userName: conversation.participant?.name)
        delegate?.showConversation(conversationObject: conversationObject)
    }
}
extension ConversationsListDataSource: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        }
    }
}
