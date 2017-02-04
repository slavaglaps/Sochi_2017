//
//  SeparatorsTableViewCell.swift
//  CWWG
//
//  Created by Alexander Zimin on 04/02/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class SeparatorsTableViewCell: UITableViewCell {
  
  var separatorLeadingConstraint: NSLayoutConstraint!
  
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
  
  var separatorView: UIView! {
    didSet {
      separatorView.backgroundColor = AppColor.seperatorColor
    }
  }
  
  var bottomSeparatorView: UIView! {
    didSet {
      bottomSeparatorView.isHidden = true
      bottomSeparatorView.backgroundColor = AppColor.seperatorColor
    }
  }
  
  var topSeparatorView: UIView! {
    didSet {
      topSeparatorView.isHidden = true
      topSeparatorView.backgroundColor = AppColor.seperatorColor
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    var constraintsToActivate: [NSLayoutConstraint] = []
    
    separatorView = UIView()
    bottomSeparatorView = UIView()
    topSeparatorView = UIView()
    
    separatorView.translatesAutoresizingMaskIntoConstraints = false
    bottomSeparatorView.translatesAutoresizingMaskIntoConstraints = false
    topSeparatorView.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(separatorView)
    contentView.addSubview(bottomSeparatorView)
    contentView.addSubview(topSeparatorView)
    
    constraintsToActivate.append(separatorView.heightAnchor.constraint(equalToConstant: 1))
    constraintsToActivate.append(bottomSeparatorView.heightAnchor.constraint(equalToConstant: 1))
    constraintsToActivate.append(topSeparatorView.heightAnchor.constraint(equalToConstant: 1))
    
    constraintsToActivate.append(separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
    constraintsToActivate.append(bottomSeparatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
    constraintsToActivate.append(topSeparatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
    
    constraintsToActivate.append(separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
    constraintsToActivate.append(bottomSeparatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
    constraintsToActivate.append(topSeparatorView.topAnchor.constraint(equalTo: contentView.topAnchor))
    
    separatorLeadingConstraint = separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
    constraintsToActivate.append(separatorLeadingConstraint)
    constraintsToActivate.append(bottomSeparatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
    constraintsToActivate.append(topSeparatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
    
    NSLayoutConstraint.activate(constraintsToActivate)
  }
  
}
