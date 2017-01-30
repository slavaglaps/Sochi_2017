//
//  ObjectPreviewViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 18/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class ObjectPreviewViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var object: ObjectRuntimeEntity!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.estimatedRowHeight = 44.0
    tableView.rowHeight = UITableViewAutomaticDimension
    // Do any additional setup after loading the view.
  }
  
  //  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  //    if let destination = segue.destination as? NewsPreviewViewController, let indexPath = sender as? IndexPath {
  //      let currentNews = news![indexPath.row]
  //      destination.currentNews = currentNews
  //    }
  //  }
}

extension ObjectPreviewViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCell(for: indexPath) as ObjectHeaderTableViewCell
      
      cell.objectImageView.image = object.imageName.image
      
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(for: indexPath) as ObjectInfoTableViewCell
      
      cell.setup(with: object.title, subtitle: object.subtitle)
      cell.sizeLabel.text = object.sizeString
      cell.objectDescriptionLabel.text = object.description
      
      cell.mapButtonPressed = {
        [weak self] in
        self?.performSegue(withIdentifier: "Map", sender: nil)
      }
      
      return cell
    }
  }
}

extension ObjectPreviewViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    // self.performSegue(withIdentifier: "Object", sender: indexPath)
  }
}
