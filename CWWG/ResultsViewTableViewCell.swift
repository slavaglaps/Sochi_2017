//
//  ResultsViewTableViewCell.swift
//  CWWG
//
//  Created by Alexander Zimin on 05/02/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class ResultsViewTableViewCell: SeparatorsTableViewCell, Reusable {
  
  override func prepareForReuse() {
    super.prepareForReuse()
    countryImageView.image = nil
  }
  
  @IBOutlet weak var fashionLineView: FashionLineView! {
    didSet {
      fashionLineView.tintColor = AppColor.seperatorColor
    }
  }
  
  @IBOutlet weak var placeLabel: UILabel! {
    didSet {
      placeLabel.textColor = AppColor.blue
      placeLabel.font = AppFont.latoRegularFont(ofSize: 17)
    }
  }
  
  @IBOutlet weak var countryImageView: UIImageView!
  
  @IBOutlet weak var nameLabel: UILabel!  {
    didSet {
      nameLabel.textColor = AppColor.black
      nameLabel.font = AppFont.latoRegularFont(ofSize: 17)
      nameLabel.adjustsFontSizeToFitWidth = true
    }
  }
  
  @IBOutlet weak var scoresBackgroundView: UIView! {
    didSet {
      scoresBackgroundView.backgroundColor = AppColor.blue
    }
  }
  
  @IBOutlet weak var scoresLabel: UILabel! {
    didSet {
      scoresLabel.textColor = AppColor.white
      scoresLabel.font = AppFont.latoBoldFont(ofSize: 17)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    separatorLeadingConstraint.constant = fashionLineView.frame.width
    countryImageView.image = nil
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
