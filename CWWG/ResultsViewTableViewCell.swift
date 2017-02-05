//
//  ResultsViewTableViewCell.swift
//  CWWG
//
//  Created by Alexander Zimin on 05/02/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class ResultsViewTableViewCell: SeparatorsTableViewCell, Reusable {
  
  @IBOutlet weak var fashionLineView: FashionLineView! {
    didSet {
      fashionLineView.tintColor = AppColor.seperatorColor
    }
  }
  
  @IBOutlet weak var placeLabel: UILabel!
  
  @IBOutlet weak var countryImageView: UIImageView!
  
  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var scoresBackgroundView: UIView!
  @IBOutlet weak var scoresLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    separatorLeadingConstraint.constant = fashionLineView.frame.width
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
