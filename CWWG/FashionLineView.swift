//
//  FashionLineView.swift
//  CWWG
//
//  Created by Alexander Zimin on 18/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

@IBDesignable
class FashionLineView: UIView {
  
  let circleRadius: CGFloat = 5
  let circleMargin: CGFloat = 2
  
  @IBInspectable
  var needToShowCircle: Bool = true {
    didSet {
      setNeedsDisplay()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.backgroundColor = UIColor.clear
  }
  
  override func draw(_ rect: CGRect) {
    let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
    let space = circleRadius * circleMargin
    
    tintColor.setStroke()
    tintColor.setFill()
    
    let topPath = UIBezierPath()
    topPath.move(to: CGPoint(x: center.x, y: 0))
    
    if needToShowCircle {
      topPath.addLine(to: CGPoint(x: center.x, y: center.y - space))
    } else {
      topPath.addLine(to: CGPoint(x: center.x, y: frame.height))
    }
    
    topPath.stroke()
    
    guard needToShowCircle else {
      return
    }
    
    let bottomPath = UIBezierPath()
    bottomPath.move(to: CGPoint(x: center.x, y: center.y + space))
    bottomPath.addLine(to: CGPoint(x: center.x, y: frame.height))
    bottomPath.stroke()
    
    let circle = UIBezierPath(ovalIn: CGRect(x: center.x - circleRadius,
                                             y: center.y - circleRadius,
                                             width: circleRadius * 2,
                                             height: circleRadius * 2))
    circle.fill()
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setNeedsLayout()
  }
  
}
