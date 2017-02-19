//
//  ViewControllersFactory.swift
//  CWWG
//
//  Created by Alexander Zimin on 24/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

struct ViewControllersFactory {
  
  static func baseViewController(withRootViewController rootViewController: UIViewController) -> UIViewController {
    let viewController = UIViewController()
    
    viewController.view.addSubview(rootViewController.view)
    viewController.addChildViewController(rootViewController)
    rootViewController.willMove(toParentViewController: viewController)
    
    return viewController
  }
  
  static func baseNavigationController(withRootViewController rootViewController: UIViewController) -> NavigationViewController {
    return NavigationViewController(rootViewController: rootViewController)
  }
  
  static var menuViewController: MenuViewController {
    let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Menu") as! MenuViewController
    return menuViewController
  }
  
  static var newsViewController: NewsFeedViewController {
    let newsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "News") as! NewsFeedViewController
    return newsViewController
  }
  
  static var objectsListViewController: ObjectsListViewController {
    return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Objects") as! ObjectsListViewController
  }
  
  static var selectLanguageController: SelectLanguageViewController {
    let newsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectLanguage") as! SelectLanguageViewController
    return newsViewController
  }
  
  static var webViewController: WebViewViewController {
    return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Web") as! WebViewViewController
  }
  
  static var resultsSearchViewController: ResultsSearchViewController {
    return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultsSearch") as! ResultsSearchViewController
  }
  
  static var scheduleViewController: ScheduleViewController {
    return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Schedule") as! ScheduleViewController
  }
  
}
