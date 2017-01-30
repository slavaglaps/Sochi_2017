//
//  ObjectsListViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 18/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class ObjectsListViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var objects: [ObjectRuntimeEntity] = ObjectRuntimeEntity.objects
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addMenuButton()
    
    tableView.estimatedRowHeight = 120
    tableView.rowHeight = UITableViewAutomaticDimension
    // Do any additional setup after loading the view.
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
    cell.setupWhatIsGoingOn(text: "Церемония открытия / закрытия Игр")
    cell.objectImageView.image = object.imageName.image
    
    return cell
  }
  
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if let destination = segue.destination as? NewsPreviewViewController, let indexPath = sender as? IndexPath {
//      let currentNews = news![indexPath.row]
//      destination.currentNews = currentNews
//    }
//  }
}

extension ObjectsListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
   // self.performSegue(withIdentifier: "Preview", sender: indexPath)
  }
}
