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
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    let image = UIImage(named: "img_navigation_bar")!
    let height = image.size.height * navigationBar.frame.width / image.size.width
    shadowImageView.frame = CGRect(x: 0, y: navigationBar.frame.origin.y, width: navigationBar.frame.width, height: height)
  }
  
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    self.viewControllers.last?.makeBackButtonEmpty()
    super.pushViewController(viewController, animated: animated)
  }
  
  func addShadow() {
    
  }
  
}
