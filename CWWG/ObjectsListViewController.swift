//
//  ObjectsListViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 18/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class ObjectsListViewController: UIViewController, UpdateLanguageNotificationObserver {
  
  @IBOutlet weak var tableView: UITableView!
  var objects: [ObjectRuntimeEntity] = ObjectRuntimeEntityContainer.entities
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addMenuButton()
    
    tableView.estimatedRowHeight = 120
    tableView.rowHeight = UITableViewAutomaticDimension
    
    NotificationCenter.default.addLanguageChangeObserver(observer: self)
    
    NetworkRequestsController.requestWhatIsGoingOnNow { [weak self] (success) in
      if success {
        self?.tableView.reloadData()
      }
    }
    
    // Do any additional setup after loading the view.
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
  }
  
  func updateLanguage() {
    self.title = Localizations.MenuItem.Objects
    objects = ObjectRuntimeEntityContainer.entities
    tableView.reloadData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? ObjectPreviewViewController, let indexPath = sender as? IndexPath {
      let object = objects[indexPath.row]
      destination.object = object
    }
  }
}

extension ObjectsListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return objects.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let object = objects[indexPath.row]
    let cell = tableView.dequeueReusableCell(for: indexPath) as ObjectTableViewCell
    
    cell.setup(with: object.title, subtitle: object.subtitle)
    cell.setupWhatIsGoingOn(text: object.event ?? "")
    cell.objectImageView.image = object.imageName.image
    
    return cell
  }
}

extension ObjectsListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    self.performSegue(withIdentifier: "Object", sender: indexPath)
  }
}
