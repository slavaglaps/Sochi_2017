//
//  NewsFeedPlainTableViewCell.swift
//  CWWG
//
//  Created by Alexander Zimin on 20/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class NewsFeedPlainTableViewCell: UITableViewCell, Reusable {
  
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
      newsTimeLabel.font = AppFont.latoRegularFont(ofSize: 11)
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
  
  // For top and bottom cell
  
  enum CellPosition {
    case normal
    case top
    case bottom
  }
  
  var position: CellPosition = .normal {
    didSet {
      switch position {
      case .normal:
        bottomSeparatorView.isHidden = true
        topSeparatorView.isHidden = true
        separatorView.isHidden = false
      case .top:
        topSeparatorView.isHidden = false
        separatorView.isHidden = false
      case .bottom:
        bottomSeparatorView.isHidden = false
        separatorView.isHidden = true
      }
    }
  }
  
  @IBOutlet weak var bottomSeparatorView: UIView! {
    didSet {
      bottomSeparatorView.isHidden = true
      bottomSeparatorView.backgroundColor = AppColor.seperatorColor
    }
  }
  
  @IBOutlet weak var topSeparatorView: UIView! {
    didSet {
      topSeparatorView.isHidden = true
      topSeparatorView.backgroundColor = AppColor.seperatorColor
    }
  }
  
  
}
