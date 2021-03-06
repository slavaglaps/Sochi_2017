//
//  ObjectInfoTableViewCell.swift
//  CWWG
//
//  Created by Alexander Zimin on 30/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class ObjectInfoTableViewCell: UITableViewCell, Reusable, UpdateLanguageNotificationObserver {
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    fashionLineView.specificMargin = min(40, frame.height / 2)
    fashionLineView.setNeedsDisplay()
  }
  
  var mapButtonPressed: (() -> ())?
  
  @IBOutlet weak var fashionLineView: FashionLineView! {
    didSet {
      fashionLineView.tintColor = AppColor.seperatorColor
    }
  }
  
  @IBOutlet weak var mapButton: UIButton! {
    didSet {
      mapButton.backgroundColor = AppColor.blue
    }
  }
  
  @IBOutlet weak var mapLabel: UILabel! {
    didSet {
      mapLabel.textColor = AppColor.white
      mapLabel.font = AppFont.latoBoldFont(ofSize: 15)
    }
  }
  
  @IBOutlet weak var objectNameLabel: UILabel!
  
  @IBOutlet weak var sizeLabel: UILabel! {
    didSet {
      sizeLabel.textColor = AppColor.gray
      sizeLabel.font = AppFont.latoRegularFont(ofSize: 12)
    }
  }
  
  @IBOutlet weak var objectDescriptionLabel: UILabel! {
    didSet {
      objectDescriptionLabel.textColor = AppColor.black
      objectDescriptionLabel.font = AppFont.latoRegularFont(ofSize: 13)
    }
  }
  
  @IBOutlet weak var separatorView: UIView! {
    didSet {
      separatorView.backgroundColor = AppColor.seperatorColor
    }
  }
  
  func setup(with title: String, subtitle: String) {
    let fullTitle = "\n«\(title)»".uppercased()
    let attributedString = NSMutableAttributedString(string: "\(subtitle)\(fullTitle)")
    
    let fullRange = NSMakeRange(0, attributedString.string.characters.count)
    let subtitleRange = NSMakeRange(0, subtitle.characters.count)
    let titleRange = NSMakeRange(subtitle.characters.count, fullTitle.characters.count)
    
    let fontsSizes = fontsSizesTuple
    
    attributedString.addAttribute(NSForegroundColorAttributeName, value: AppColor.black, range: fullRange)
    attributedString.addAttribute(NSFontAttributeName, value: AppFont.latoBoldFont(ofSize: fontsSizes.0), range: subtitleRange)
    attributedString.addAttribute(NSFontAttributeName, value: AppFont.latoBoldFont(ofSize: fontsSizes.1), range: titleRange)
    
    objectNameLabel.attributedText = attributedString
  }
  
  private var fontsSizesTuple: (CGFloat, CGFloat) {
    let bounds = UIScreen.main.bounds
    if bounds.width < 340 {
      return (13, 19)
    } else {
      return (15, 21)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    NotificationCenter.default.addLanguageChangeObserver(observer: self)
    // Initialization code
  }
  
  func updateLanguage() {
    mapLabel.text = Localizations.Map.Title
  }
  
  
  @IBAction func mapButtonAction(_ sender: UIButton) {
    mapButtonPressed?()
  }
  
}
