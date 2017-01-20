//
//  NewsFeedPlainTableViewCell.swift
//  CWWG
//
//  Created by Alexander Zimin on 20/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class NewsFeedPlainTableViewCell: UITableViewCell, Reusable {
  
  @IBOutlet weak var newsDescriptionLabel: UILabel!
  @IBOutlet weak var newsTimeLabel: UILabel!
  @IBOutlet weak var separatorView: UIView!
  
  @IBOutlet weak var separatorViewHeightConstraint: NSLayoutConstraint! {
    didSet {
      separatorViewHeightConstraint.constant = 0.5
    }
  }
  
}
