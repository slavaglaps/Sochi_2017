//
//  SelectionViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 06/02/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

protocol SelectionViewControllerDelegate {
  func selectionViewController(selectionViewController: SelectionViewController, didSelect element: SelectionEntity)
}

protocol SelectionEntity {
  var name: String { get }
  var id: Int { get }
}

class SelectionViewController: UIViewController {
  
  var delegate: SelectionViewControllerDelegate?
  
  @IBOutlet weak var tableView: UITableView!
  
  var elemets: [SelectionEntity] = [] {
    didSet {
      if isViewLoaded {
        tableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.estimatedRowHeight = 44.0
    tableView.rowHeight = UITableViewAutomaticDimension
    // Do any additional setup after loading the view.
  }
  
}

extension SelectionViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return elemets.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath) as DescriptionTableViewCell
    
    let element = elemets[indexPath.row]
    
    cell.newsDescriptionLabel.text = element.name
    cell.updateCellPosition(at: indexPath, inside: tableView)
    
    return cell
  }
}

extension SelectionViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.selectionViewController(selectionViewController: self, didSelect: elemets[indexPath.row])
    _ = self.navigationController?.popViewController(animated: true)
  }
}
