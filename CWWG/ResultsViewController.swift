//
//  ResultsViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 18/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var placeLabel: UILabel!
  @IBOutlet weak var countryLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var scroreLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for label in [placeLabel, countryLabel, nameLabel, scroreLabel] {
      label?.font = AppFont.latoRegularFont(ofSize: 13)
      label?.textColor = AppColor.lightBlue
    }
    
    placeLabel.text = Localizations.Results.Place
    countryLabel.text = Localizations.Results.Country
    nameLabel.text = Localizations.Results.Name
    scroreLabel.text = Localizations.Results.Score
    
    fill(with: "Скалолазанье", additionalInfo: "Женская квалификация")
    // Do any additional setup after loading the view.
  }
  
  func fill(with sportName: String, additionalInfo: String) {
    let sportName = "\(sportName)\n"
    let attributedString = NSMutableAttributedString(string: "\(sportName)\(additionalInfo)")
    
    let subtitleRange = NSMakeRange(0, sportName.characters.count)
    let titleRange = NSMakeRange(sportName.characters.count, additionalInfo.characters.count)
    
    attributedString.addAttribute(NSForegroundColorAttributeName, value: AppColor.black, range: subtitleRange)
    attributedString.addAttribute(NSForegroundColorAttributeName, value: AppColor.gray, range: titleRange)
    attributedString.addAttribute(NSFontAttributeName, value: AppFont.latoRegularFont(ofSize: 17), range: subtitleRange)
    attributedString.addAttribute(NSFontAttributeName, value: AppFont.latoRegularFont(ofSize: 11), range: titleRange)
    
    let label = UILabel()
    label.numberOfLines = 2
    label.textAlignment = .center
    label.attributedText = attributedString
    
    label.sizeToFit()
    navigationItem.titleView = label
  }
  
}

extension ResultsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath) as ResultsViewTableViewCell
    
    cell.updateCellPosition(at: indexPath, inside: tableView)
    
    return cell
    
  }
}
