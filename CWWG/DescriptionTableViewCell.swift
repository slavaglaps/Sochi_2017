//
//  DescriptionTableViewCell.swift
//  CWWG
//
//  Created by Alexander Zimin on 24/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: SeparatorsTableViewCell, Reusable {
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    fashionLineView.specificMargin = min(40, frame.height / 2)
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
  
  override func awakeFromNib() {
    super.awakeFromNib()
     separatorLeadingConstraint.constant = fashionLineView.frame.width
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
