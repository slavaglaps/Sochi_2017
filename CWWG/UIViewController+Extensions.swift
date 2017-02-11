//
//  UIViewController+Extensions.swift
//  CWWG
//
//  Created by Alexander Zimin on 24/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit.UIViewController

extension UIViewController {
  func makeBackButtonEmpty() {
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  }
  
  func addMenuButton() {
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "img_icon_menu"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.openMenuButtonAction(_:)))
  }
  
  func openMenuButtonAction(_ sender: UIBarButtonItem) {
    let menuViewController = ViewControllersFactory.menuViewController
    self.present(menuViewController, animated: true, completion: nil)
  }
}
