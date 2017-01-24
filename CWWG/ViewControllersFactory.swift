//
//  ViewControllersFactory.swift
//  CWWG
//
//  Created by Alexander Zimin on 24/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

struct ViewControllersFactory {
  static var menuViewController: MenuViewController {
    let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Menu") as! MenuViewController
    return menuViewController
  }
  
  static var newsViewController: NewsFeedViewController {
    let newsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "News") as! NewsFeedViewController
    return newsViewController
  }
}
