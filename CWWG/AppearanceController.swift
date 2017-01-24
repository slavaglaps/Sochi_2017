//
//  AppearanceController.swift
//  CWWG
//
//  Created by Alexander Zimin on 24/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

struct AppearanceController {
  static func setupAppearance() {
    setupNavigationBarAppearance()
  }
  
  private static func setupNavigationBarAppearance() {
    UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: AppFont.latoRegularFont(ofSize: 17), NSForegroundColorAttributeName: AppColor.titleColor]
    UINavigationBar.appearance().tintColor = AppColor.navigationBarTintColor
//    UINavigationBar.appearance().shadowImage = UIImage()
//    UINavigationBar.appearance().setBackgroundImage(UIImage(named: "header-background"), for: .default)
  }
  
}
