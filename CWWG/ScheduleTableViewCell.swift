//
//  ScheduleTableViewCell.swift
//  CWWG
//
//  Created by Alexander Zimin on 04/02/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: SeparatorsTableViewCell, Reusable {
  
  @IBOutlet weak var timeLabelBackgroundView: UIView! {
    didSet {
      timeLabelBackgroundView.backgroundColor = AppColor.blue
    }
  }
  
  @IBOutlet weak var timeLabel: UILabel! {
    didSet {
      timeLabel.font = AppFont.latoBoldFont(ofSize: 15)
      timeLabel.textColor = AppColor.white
    }
  }
  
  @IBOutlet weak var eventNameLabel: UILabel! {
    didSet {
      eventNameLabel.font = AppFont.latoRegularFont(ofSize: 17)
      eventNameLabel.textColor = AppColor.black
    }
  }
  
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var placeNameLabel: UILabel!
  
  @IBOutlet weak var fashionLineView: FashionLineView! {
    didSet {
      fashionLineView.tintColor = AppColor.seperatorColor
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    separatorLeadingConstraint.constant = fashionLineView.frame.width
  }
  
  func setupWithPlace(nameString: String) {
    let subtitle = Localizations.Schedule.TakePlace + " "
    let attributedString = NSMutableAttributedString(string: "\(subtitle)\(nameString)")
    
    let subtitleRange = NSMakeRange(0, subtitle.characters.count)
    let titleRange = NSMakeRange(subtitle.characters.count, nameString.characters.count)
    
    attributedString.addAttribute(NSForegroundColorAttributeName, value: AppColor.gray, range: subtitleRange)
    attributedString.addAttribute(NSForegroundColorAttributeName, value: AppColor.blue, range: titleRange)
    attributedString.addAttribute(NSFontAttributeName, value: AppFont.latoRegularFont(ofSize: 12), range: subtitleRange)
    attributedString.addAttribute(NSFontAttributeName, value: AppFont.latoBoldFont(ofSize: 12), range: titleRange)
    
    placeNameLabel.attributedText = attributedString
  }
  
}
