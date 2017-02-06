//
//  PlaceholderLabel.swift
//  CWWG
//
//  Created by Alexander Zimin on 06/02/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class PlaceholderLabel: UILabel {

  var textString: String? {
    didSet {
      updateText()
    }
  }
  var placeholderString: String? {
    didSet {
      updateText()
    }
  }
  
  var realAlpha: CGFloat = 1 {
    didSet {
      updateAlphaValue()
    }
  }
  
  var placeholderAlpha: CGFloat = 1 {
    didSet {
      updateAlphaValue()
    }
  }
  
  private func updateText() {
    if let textString = textString {
      text = textString
    } else {
      text = placeholderString
    }
    updateAlphaValue()
  }
  
  private func updateAlphaValue() {
    if textString != nil {
      alpha = realAlpha
    } else {
      alpha = placeholderAlpha
    }
  }
}
