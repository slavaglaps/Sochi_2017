//
//  String+Extensions.swift
//  CWWG
//
//  Created by Alexander Zimin on 30/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

extension String {
  var image: UIImage? {
    return UIImage(named: self)
  }
}
