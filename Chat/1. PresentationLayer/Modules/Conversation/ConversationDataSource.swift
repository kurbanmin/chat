//
//  ConversationDataSource.swift
//  Chat
//
//  Created by Qurban on 02.04.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation
import CoreData

class ConversationDataSource: NSObject {
    let storageManager = StorageManager.shared

    var tableView: UITableView
    var frc: NSFetchedResultsController<Message>!

    init(conversationID: String, tableView: UITableView) {
        self.tableView = tableView
        super.init()

        tableView.dataSource = self

        guard let fetchRequest = Message.fetchRequestMessages(with: conversationID, model: self.storageManager.model)
        else { return }

        let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [dateSortDescriptor]

        self.frc = NSFetchedResultsController<Message>(fetchRequest: fetchRequest,
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

extension ConversationDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = self.frc.sections else {
            fatalError("No sections in frc")
        }

        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self.frc.object(at: indexPath)
        let identifier = message.isIncoming ? "InputMessageCell" : "OutputMessageCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                       for: indexPath) as? MessageCell
        else { return UITableViewCell() }

        cell.messageText = message.text

        return cell
    }
}

extension ConversationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return conversation.messages.count
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return UITableViewCell()
    }
}

extension ConversationDataSource: NSFetchedResultsControllerDelegate {
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
