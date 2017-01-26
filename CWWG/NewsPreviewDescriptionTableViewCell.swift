//
//  NewsPreviewDescriptionTableViewCell.swift
//  CWWG
//
//  Created by Alexander Zimin on 24/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class NewsPreviewDescriptionTableViewCell: UITableViewCell, Reusable {
  
  override func layoutIfNeeded() {
    super.layoutIfNeeded()
    fashionLineView.setNeedsDisplay()
  }
  
  @IBOutlet weak var newsDescriptionLabel: UILabel! {
    didSet {
      newsDescriptionLabel.textColor = AppColor.black
      newsDescriptionLabel.font = AppFont.latoRegularFont(ofSize: 15)
      newsDescriptionLabel.numberOfLines = 0
    }
  }
  
  @IBOutlet weak var fashionLineView: FashionLineView! {
    didSet {
      fashionLineView.tintColor = AppColor.seperatorColor
    }
  }
  
  @IBOutlet weak var separatorView: UIView! {
    didSet {
      separatorView.backgroundColor = AppColor.seperatorColor
    }
  }
  
  @IBOutlet var separatorsViewHeightConstraints: [NSLayoutConstraint]! {
    didSet {
      for constraint in separatorsViewHeightConstraints {
        constraint.constant = 1
      }
    }
  }
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
