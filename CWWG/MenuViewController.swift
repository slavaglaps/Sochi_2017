//
//  MenuViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 18/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit
import SafariServices

class MenuViewController: UIViewController, UpdateLanguageNotificationObserver {
  
  @IBOutlet weak var englishLabel: UILabel!
  @IBOutlet weak var russianLabel: UILabel!
  
  @IBOutlet weak var menuListItem: MenuListView!
  
  var menuItems: [MenuListItem] = [.schedule, .results, .news, .broadcast, .quest, .objects, .messenger, .cism, .military]
  
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
  
  enum SocialNetwork {
    case facebook
    case vk
    case twitter
    case instagram
    
    var url: URL {
      let urlString: String
      switch self {
      case .facebook:
        urlString = "https://www.facebook.com/sochi2017/"
      case .vk:
        urlString = "https://vk.com/cismsochi2017"
      case .twitter:
        urlString = "https://twitter.com/2017Cism"
      case .instagram:
        urlString = "https://www.instagram.com/cism_sochi2017/"
      }
      return URL(string: urlString)!
    }
  }
  
  @IBAction func openSocialNetworkAction(_ sender: UIButton) {
    let networks: [SocialNetwork] = [SocialNetwork.facebook, SocialNetwork.vk, SocialNetwork.twitter, SocialNetwork.instagram]
    let network = networks[sender.tag]
    UIApplication.shared.openURL(network.url)
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
    case .schedule:
      showSchedule()
    case .objects:
      showObjects()
    case .results:
      openResults()
    default:
      self.openUrl(string: "https://www.google.de")
      print(index)
    }
  }
}

extension MenuViewController {
  func showNews() {
    RouterController.shared.baseNavigationController.viewControllers = [ViewControllersFactory.newsViewController]
    self.dismiss(animated: true, completion: nil)
  }
  
  func showObjects() {
    RouterController.shared.baseNavigationController.viewControllers = [ViewControllersFactory.objectsListViewController]
    self.dismiss(animated: true, completion: nil)
  }
  
  func showSchedule() {
    RouterController.shared.baseNavigationController.viewControllers = [ViewControllersFactory.scheduleViewController]
    self.dismiss(animated: true, completion: nil)
  }
  
  func openResults() {
    RouterController.shared.baseNavigationController.viewControllers = [ViewControllersFactory.resultsSearchViewController]
    self.dismiss(animated: true, completion: nil)
  }
  
  func openUrl(string: String) {
    let safariViewController = SFSafariViewController(url: URL(string: string)!)
    self.present(safariViewController, animated: true, completion: nil)
  }
}
