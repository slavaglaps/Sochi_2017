//
//  ObjectTableViewCell.swift
//  CWWG
//
//  Created by Alexander Zimin on 30/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class ObjectTableViewCell: UITableViewCell, Reusable {
  
  @IBOutlet weak var objectImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var eventLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func setup(with title: String, subtitle: String) {
    let fullTitle = "\n«\(title)»".uppercased()
    let attributedString = NSMutableAttributedString(string: "\(subtitle)\(fullTitle)")
    
    let fullRange = NSMakeRange(0, attributedString.string.characters.count)
    let subtitleRange = NSMakeRange(0, subtitle.characters.count)
    let titleRange = NSMakeRange(subtitle.characters.count, fullTitle.characters.count)
    
    attributedString.addAttribute(NSForegroundColorAttributeName, value: AppColor.white, range: fullRange)
    attributedString.addAttribute(NSFontAttributeName, value: AppFont.latoRegularFont(ofSize: 13), range: subtitleRange)
    attributedString.addAttribute(NSFontAttributeName, value: AppFont.latoRegularFont(ofSize: 20), range: titleRange)
    
    nameLabel.attributedText = attributedString
  }
  
  func setupWhatIsGoingOn(text: String) {
    if text.isEmpty {
      eventLabel.attributedText = NSAttributedString(string: "")
      return
    }
    
    let subtitle = Localizations.ObjectPreview.WhatIsGoingOn + " "
    let attributedString = NSMutableAttributedString(string: "\(subtitle)\(text)")
    
    let fullRange = NSMakeRange(0, attributedString.string.characters.count)
    let subtitleRange = NSMakeRange(0, subtitle.characters.count)
    let titleRange = NSMakeRange(subtitle.characters.count, text.characters.count)
    
    attributedString.addAttribute(NSForegroundColorAttributeName, value: AppColor.white, range: fullRange)
    attributedString.addAttribute(NSFontAttributeName, value: AppFont.latoLightFont(ofSize: 13), range: subtitleRange)
    attributedString.addAttribute(NSFontAttributeName, value: AppFont.latoRegularFont(ofSize: 13), range: titleRange)
    
    eventLabel.attributedText = attributedString
  }
  
}
