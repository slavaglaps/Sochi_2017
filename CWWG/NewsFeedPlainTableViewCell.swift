//
//  NewsFeedPlainTableViewCell.swift
//  CWWG
//
//  Created by Alexander Zimin on 20/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class NewsFeedPlainTableViewCell: SeparatorsTableViewCell, Reusable {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    separatorLeadingConstraint.constant = fashionLineView.frame.width
  }
  
  override func layoutIfNeeded() {
    super.layoutIfNeeded()
    fashionLineView.setNeedsDisplay()
    
    separatorLeadingConstraint.constant = fashionLineView.frame.width
  }
  
  @IBOutlet weak var newsDescriptionLabel: UILabel! {
    didSet {
      newsDescriptionLabel.textColor = AppColor.black
      newsDescriptionLabel.font = AppFont.latoRegularFont(ofSize: 15)
      newsDescriptionLabel.numberOfLines = 0
    }
  }
  
  @IBOutlet weak var newsTimeLabel: UILabel! {
    didSet {
      newsTimeLabel.textColor = AppColor.gray
      newsTimeLabel.font = AppFont.latoRegularFont(ofSize: 12)
    }
  }
  
  @IBOutlet weak var fashionLineView: FashionLineView! {
    didSet {
      fashionLineView.tintColor = AppColor.seperatorColor
    }
  }
  
}
