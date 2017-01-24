//
//  NavigationViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 24/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
  
  var shadowImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationBar.shadowImage = UIImage()
    navigationBar.setBackgroundImage(UIImage(), for: .default)
    
    navigationBar.barTintColor = AppColor.white
    navigationBar.isTranslucent = false
    
    shadowImageView = UIImageView(image: UIImage(named: "img_navigation_bar"))
    
    view.insertSubview(shadowImageView, belowSubview: navigationBar)
//    
//    shadowImageView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor).isActive = true
//    shadowImageView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor).isActive = true
// //   shadowImageView.topAnchor.constraint(equalTo: navigationBar.topAnchor).isActive = true
//    shadowImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    shadowImageView.frame = CGRect(x: 0, y: navigationBar.frame.origin.y, width: navigationBar.frame.width, height: CGFloat.greatestFiniteMagnitude)
    shadowImageView.sizeToFit()
  }
  
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    self.viewControllers.last?.makeBackButtonEmpty()
    super.pushViewController(viewController, animated: animated)
  }
  
  func addShadow() {
    
  }
  
}
