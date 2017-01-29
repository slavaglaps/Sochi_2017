//
//  MenuViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 18/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UpdateLanguageNotificationObserver {
  
  @IBOutlet weak var englishLabel: UILabel!
  @IBOutlet weak var russianLabel: UILabel!
  
  @IBOutlet weak var menuListItem: MenuListView!
  
  var menuItems: [MenuListItem] = [.news, .schedule, .objects, .results, .broadcast, .accreditation, .quiz]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    menuListItem.dataSource = self
    menuListItem.delegate = self
    
    NotificationCenter.default.addLanguageChangeObserver(observer: self)
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func selectNewsButtonAction(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func selectRussianLanguageAction(_ sender: UIButton) {
    LocalizationController.select(localization: .russian)
  }
  
  @IBAction func selectEnglishLanguageAction(_ sender: UIButton) {
    LocalizationController.select(localization: .english)
  }
  
  func updateLanguage() {
    menuListItem.updateContent()
    
    if LocalizationController.currentLocalization == .russian {
      englishLabel.alpha = 0.5
      russianLabel.alpha = 1
    } else {
      englishLabel.alpha = 1
      russianLabel.alpha = 0.5
    }
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}

extension MenuViewController: MenuListViewDataSource {
  func numberOfButtons(in list: MenuListView) -> Int {
    return menuItems.count
  }
  
  func buttonStringAtIndex(in list: MenuListView, at index: Int) -> String {
    return menuItems[index].title.uppercased()
  }
}

extension MenuViewController: MenuListViewDelegate {
  func buttonWasTouched(in list: MenuListView, at index: Int) {
    let menuItem = menuItems[index]
    switch menuItem {
    case .news:
      showNews()
    default:
      print(index)
    }
  }
}

extension MenuViewController {
  func showNews() {
    RouterController.shared.baseNavigationController.viewControllers = [ViewControllersFactory.newsViewController]
    self.dismiss(animated: true, completion: nil)
  }
}
