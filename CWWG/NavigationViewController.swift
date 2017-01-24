//
//  NavigationViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 24/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    super.pushViewController(viewController, animated: animated)
    self.navigationItem.backBarButtonItem = nil
  }
  
  
}
