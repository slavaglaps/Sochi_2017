//
//  ResultsSearchViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 18/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class ResultsSearchViewController: UIViewController, UpdateLanguageNotificationObserver {
  
  @IBOutlet weak var sportButton: UIButton!
  @IBOutlet weak var currentSportButton: UIButton!
  @IBOutlet weak var searchButton: UIButton!
  
  @IBOutlet weak var sportLabel: UILabel!
  @IBOutlet weak var currentSportLabel: UILabel!
  @IBOutlet weak var searchLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for label in [sportLabel, currentSportLabel, searchLabel] {
      label?.textColor = AppColor.black
      label?.font = AppFont.latoRegularFont(ofSize: 14)
    }
    
    addMenuButton()
    NotificationCenter.default.addLanguageChangeObserver(observer: self)
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func updateLanguage() {
    title = Localizations.MenuItem.Results
  }
  
  @IBAction func sportButtonAction(_ sender: UIButton) {
    
  }
  
  @IBAction func currentSportButtonAction(_ sender: UIButton) {
    
  }
  
  @IBAction func searchButtonAction(_ sender: UIButton) {
    
  }
  
  
  
}
