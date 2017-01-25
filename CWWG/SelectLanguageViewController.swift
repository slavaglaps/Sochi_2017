//
//  SelectLanguageViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 18/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class SelectLanguageViewController: UIViewController {
  
  @IBOutlet weak var selectLanguageLabel: UILabel! {
    didSet {
      selectLanguageLabel.text = Localizations.SelectLanguage.Title
    }
  }
  
  @IBOutlet weak var languagesBackgroundView: UIView! {
    didSet {
      languagesBackgroundView.layer.cornerRadius = 4
    }
  }
  
  @IBAction func selectRussianButtonAction(_ sender: UIButton) {
    LocalizationController.select(localization: .russian)
    exit()
  }
  
  @IBAction func selectEnglishButtonAction(_ sender: UIButton) {
    LocalizationController.select(localization: .english)
    exit()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func exit() {
    if let delegate = UIApplication.shared.delegate as? AppDelegate {
      delegate.showNewsViewControllerAsRootViewController()
    }
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return UIStatusBarStyle.lightContent
  }
  
}
