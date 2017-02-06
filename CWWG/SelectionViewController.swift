//
//  SelectionViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 06/02/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

protocol SelectionViewControllerDelegate {
  func selectionViewController(selectionViewController: SelectionViewController, didSelect element: String)
}

class SelectionViewController: UIViewController {
  
  var delegate: SelectionViewControllerDelegate?
  
  @IBOutlet weak var tableView: UITableView!
  
  var elemets = ["Горные лыжи", "Водные лыжи", "Спуск со склона"]
  
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
    
    cell.newsDescriptionLabel.text = elemets[indexPath.row]
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
