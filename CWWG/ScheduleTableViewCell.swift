//
//  ScheduleTableViewCell.swift
//  CWWG
//
//  Created by Alexander Zimin on 04/02/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: SeparatorsTableViewCell, Reusable {
  
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
