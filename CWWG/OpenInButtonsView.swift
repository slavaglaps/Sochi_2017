//
//  OpenInButtonsView.swift
//  CWWG
//
//  Created by Alexander Zimin on 31/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

private let buttonHeight: CGFloat = 44

class OpenInButtonsView: UIView {
  
  var buttonDidTapAt: ((_ index: Int) -> ())?
  var heightConstraint: NSLayoutConstraint!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    layer.cornerRadius = 5
    
    layer.shadowOffset = CGSize(width: 0, height: 1)
    layer.shadowRadius = 4
    layer.shadowOpacity = 0.2
    
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
  var buttons: [UIButton] = []
  
  func setupWithButtons(titles: [String]) {
    _ = subviews.map({ $0.removeFromSuperview() })
    buttons = []
    
    var constraintsToActivate: [NSLayoutConstraint] = []
    
    for (index, title) in titles.enumerated() {
      let button = UIButton(type: .system)
      
      button.translatesAutoresizingMaskIntoConstraints = false
      button.setBackgroundImage(UIImage(named: "img_btn_dark_selection"), for: .highlighted)
      button.addTarget(self, action: #selector(self.buttonDidTouched(_:)), for: .touchUpInside)
      button.tag = index
      
      self.addSubview(button)
      
      if let lastButton = buttons.last {
        constraintsToActivate.append(button.topAnchor.constraint(equalTo: lastButton.bottomAnchor))
        
        let separator = UIView()
        separator.backgroundColor = AppColor.seperatorColor
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(separator)
        
        constraintsToActivate.append(separator.heightAnchor.constraint(equalToConstant: 1))
        constraintsToActivate.append(separator.topAnchor.constraint(equalTo: lastButton.bottomAnchor))
        constraintsToActivate.append(separator.leadingAnchor.constraint(equalTo: leadingAnchor))
        constraintsToActivate.append(separator.trailingAnchor.constraint(equalTo: trailingAnchor))
      } else {
        constraintsToActivate.append(button.topAnchor.constraint(equalTo: topAnchor))
      }
      
      constraintsToActivate.append(button.heightAnchor.constraint(equalToConstant: buttonHeight))
      constraintsToActivate.append(button.leadingAnchor.constraint(equalTo: leadingAnchor))
      constraintsToActivate.append(button.trailingAnchor.constraint(equalTo: trailingAnchor))
      
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.text = title
      label.font = AppFont.latoRegularFont(ofSize: 13)
      label.textColor = AppColor.darkBlueGrey
      
      button.addSubview(label)
      constraintsToActivate.append(label.centerXAnchor.constraint(equalTo: button.centerXAnchor))
      constraintsToActivate.append(label.centerYAnchor.constraint(equalTo: button.centerYAnchor))
      
      buttons.append(button)
    }
    
    if let lastButton = buttons.last {
      constraintsToActivate.append(lastButton.bottomAnchor.constraint(equalTo: bottomAnchor))
    }
    
    NSLayoutConstraint.activate(constraintsToActivate)
  }
  
  @objc private func buttonDidTouched(_ sender: UIButton) {
    buttonDidTapAt?(sender.tag)
  }
  
}
