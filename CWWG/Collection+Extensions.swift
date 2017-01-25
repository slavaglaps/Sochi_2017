//
//  Collection+Extensions.swift
//  CWWG
//
//  Created by Alexander Zimin on 25/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
  
  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  func safeObject(atIndex index: Index) -> Generator.Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
