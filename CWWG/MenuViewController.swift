//
//  MenuViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 18/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UpdateLanguageNotificationObserver {
  
  @IBOutlet weak var newsButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addLanguageChangeObserver(observer: self)
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func selectNewsButtonAction(_ sender: UIButton) {
    RouterController.shared.baseNavigationController.viewControllers = [ViewControllersFactory.newsViewController]
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func selectRussianLanguageAction(_ sender: UIButton) {
    LocalizationController.select(localization: .russian)
  }
  
  @IBAction func selectEnglishLanguageAction(_ sender: UIButton) {
    LocalizationController.select(localization: .english)
  }
  
  func updateLanguage() {
    newsButton.setTitle(Localizations.News.Title, for: .normal)
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
