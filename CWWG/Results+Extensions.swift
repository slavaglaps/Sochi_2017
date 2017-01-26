//
//  Results+Extensions.swift
//  CWWG
//
//  Created by Alexander Zimin on 26/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit
import RealmSwift

extension Results {
  func addTableObserver(tableView: UITableView) -> NotificationToken {
    let notificationToken = self.addNotificationBlock { (changes: RealmCollectionChange) in
      switch changes {
      case .initial:
        // Results are now populated and can be accessed without blocking the UI
        tableView.reloadData()
        break
      case .update(_, let deletions, let insertions, let modifications):
        // Query results have changed, so apply them to the UITableView
        tableView.beginUpdates()
        tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                             with: .automatic)
        tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                             with: .automatic)
        tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                             with: .automatic)
        tableView.endUpdates()
        break
      case .error(let error):
        // An error occurred while opening the Realm file on the background worker thread
        print("Update news error: \(error)")
        break
      }
    }
    return notificationToken
  }
}
