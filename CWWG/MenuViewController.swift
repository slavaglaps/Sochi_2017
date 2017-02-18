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
  
  @IBOutlet weak var weatherLabel: UILabel! {
    didSet {
      weatherLabel.font = AppFont.latoRegularFont(ofSize: 15)
    }
  }
  @IBOutlet weak var weatherImageView: UIImageView!
  @IBOutlet weak var weatherView: UIView! {
    didSet {
      weatherView.isHidden = true
    }
  }
  
  // .broadcast
  var menuItems: [MenuListItem] = [.schedule, .results, .objects, .medals, .news, .quest, .messenger, .cism]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    menuListItem.dataSource = self
    menuListItem.delegate = self
    
    updateWeather()
    
    NotificationCenter.default.addLanguageChangeObserver(observer: self)
    // Do any additional setup after loading the view.
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    NetworkRequestsController.requestWeather { [weak self] (result) in
      guard let result = result, let strongSelf = self else { return }
      strongSelf.weatherView.isHidden = false
      
      writeFunction(block: {
        SettingsEntity.value?.lastWeatherId = result.id
        SettingsEntity.value?.lastWeatherDegree = result.degree
      })
      
      strongSelf.updateWeather()
    }
  }
  
  func updateWeather() {
    let weatherId = SettingsEntity.value?.lastWeatherId ?? 0
    let weatherDegree = SettingsEntity.value?.lastWeatherDegree ?? 0
    
    if weatherId > 0 {
      self.updateWeather(withDegree: weatherDegree, weatherId: weatherId)
    }
  }
  
  func updateWeather(withDegree degree: Float, weatherId: Int) {
    self.weatherView.isHidden = false
    
    let intDegree = Int(round(degree))
    
    var string: String
    if intDegree > 0 {
      string = "+\(intDegree)°C"
    } else {
      string = "\(intDegree)°C"
    }
    
    self.weatherLabel.text = string
    self.weatherImageView.image = WeatherHelper.parseWeatherId(id: weatherId)
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
    case .broadcast:
      openBroadcast()
    case .messenger:
      openMessenger()
    case .quest:
      openQuiz()
    case .medals:
      showMedals()
    case .cism:
      showAboutCISM()
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
  
  func openBroadcast() {
    AlertViewHelper.showAlertView(with: "", message: Localizations.Debug.ThisPartWouldWork(value1: 22), buttonTitle: "Ok", fromViewController: self)
  }
  
  func openMessenger() {
    AlertViewHelper.showAlertView(with: "", message: Localizations.Debug.ThisPartWouldWork(value1: 21), buttonTitle: "Ok", fromViewController: self)
  }
  
  func openQuiz() {
    AlertViewHelper.showAlertView(with: "", message: Localizations.Debug.ThisPartWouldWork(value1: 21), buttonTitle: "Ok", fromViewController: self)
  }
  
  func showMedals() {
    let webController = ViewControllersFactory.webViewController
    webController.type = .medal
    RouterController.shared.baseNavigationController.viewControllers = [webController]
    self.dismiss(animated: true, completion: nil)
    // openUrl(string: pdfUrl)
  }
  
  func showAboutCISM() {
    let webController = ViewControllersFactory.webViewController
    webController.type = .cism
    RouterController.shared.baseNavigationController.viewControllers = [webController]
    self.dismiss(animated: true, completion: nil)
  }
  
  func openUrl(string: String) {
    let safariViewController = SFSafariViewController(url: URL(string: string)!)
    self.present(safariViewController, animated: true, completion: nil)
  }
}
