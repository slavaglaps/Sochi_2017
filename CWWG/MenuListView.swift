//
//  MenuListView.swift
//  CWWG
//
//  Created by Alexander Zimin on 29/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

protocol MenuListViewDataSource {
  func numberOfButtons(in list: MenuListView) -> Int
  func buttonStringAtIndex(in list: MenuListView, at index: Int) -> String
}

protocol MenuListViewDelegate {
  func buttonWasTouched(in list: MenuListView, at index: Int)
}

class MenuListView: UIView {
  
  var font: UIFont {
    if UIScreen.main.bounds.height > 500 {
      return AppFont.latoRegularFont(ofSize: 14)
    } else {
      return AppFont.latoRegularFont(ofSize: 12)
    }
  }
  
  @IBInspectable var dataSource: MenuListViewDataSource? {
    didSet {
      updateContent()
    }
  }
  
  @IBInspectable var delegate: MenuListViewDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    updateContent()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    numberOfComponents = 0
    updateContent()
  }
  
  private var numberOfComponents: Int = 0
  private var buttons: [UIButton] = []
  private var separators: [UIImageView] = []
  
  func updateContent() {
    let newNumberOfComponents = dataSource?.numberOfButtons(in: self) ?? 0
    if numberOfComponents == newNumberOfComponents {
      lightUpdate()
    } else {
      numberOfComponents = newNumberOfComponents
      fullUpdate()
    }
  }
  
  private func lightUpdate() {
    for (index, button) in buttons.enumerated() {
      let title = dataSource?.buttonStringAtIndex(in: self, at: index) ?? ""
      button.setTitle(title, for: .normal)
    }
  }
  
  private func fullUpdate() {
    _ = buttons.map({ $0.removeFromSuperview() })
    _ = separators.map({ $0.removeFromSuperview() })
    buttons = []
    separators = []
    
    let circlesImage = UIImage(named: "img_separator_circles")!
    
    let separatorSize = circlesImage.size
    let fontHeight = font.pointSize
    let size = self.frame.size
    
    let elementsSpace = fontHeight * CGFloat(numberOfComponents) + separatorSize.height * CGFloat(numberOfComponents - 1)
    let space = (size.height - elementsSpace) / CGFloat(numberOfComponents * 2)
    
    var currentY: CGFloat = 0
    for i in 0..<numberOfComponents {
      let title = dataSource?.buttonStringAtIndex(in: self, at: i) ?? ""
      let button = UIButton(type: UIButtonType.system)
      button.frame = CGRect(x: 0, y: currentY, width: size.width, height: fontHeight + space * 2)
      button.setTitle(title, for: .normal)
      button.setTitleColor(AppColor.white, for: .normal)
      button.tag = i
      button.addTarget(self, action: #selector(self.buttonDidTouch(button:)), for: .touchUpInside)
      button.titleLabel?.font = font
      buttons.append(button)
      
      currentY += (fontHeight + space * 2)
      
      // If not the last
      if i != (numberOfComponents - 1) {
        let separator = UIImageView(image: circlesImage)
        separator.sizeToFit()
        var separatorFrame = separator.frame
        separatorFrame.origin.y = currentY
        separatorFrame.origin.x = (size.width - separatorSize.width) / 2
        separator.frame = separatorFrame
        
        currentY += (separatorSize.height)
         separators.append(separator)
      }
    }
    
    _ = buttons.map({ self.addSubview($0) })
    _ = separators.map({ self.addSubview($0) })
  }
  
  func buttonDidTouch(button: UIButton) {
    delegate?.buttonWasTouched(in: self, at: button.tag)
  }
}
