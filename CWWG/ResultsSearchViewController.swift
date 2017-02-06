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
  
  @IBOutlet weak var sportLabel: PlaceholderLabel!
  @IBOutlet weak var currentSportLabel: PlaceholderLabel!
  @IBOutlet weak var searchLabel: UILabel!
  
  var selectedSport: String? = nil {
    didSet {
      selectedCurrentSport = nil
      isCurrentSportActive = selectedSport != nil
      sportLabel.textString = selectedSport
    }
  }
  
  var selectedCurrentSport: String? {
    didSet {
      isSearchActive = selectedCurrentSport != nil
      currentSportLabel.textString = selectedCurrentSport
    }
  }
  
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
    
    sportLabel.placeholderAlpha = 0.8
    
    sportLabel.placeholderString = Localizations.ResultSearch.Sport
    currentSportLabel.placeholderString = Localizations.ResultSearch.Competition
    searchLabel.text = Localizations.ResultSearch.Search
    
    selectedSport = nil
  }
  
  @IBAction func sportButtonAction(_ sender: UIButton) {
    selectedSport = "Крутой"
  }
  
  @IBAction func currentSportButtonAction(_ sender: UIButton) {
    selectedCurrentSport = "Очень крутой"
  }
  
  @IBAction func searchButtonAction(_ sender: UIButton) {
    
  }
  
  var isCurrentSportActive: Bool = false {
    didSet {
      currentSportButton.isEnabled = isCurrentSportActive
      
      let alpha: CGFloat = isCurrentSportActive ? 1 : 0.7
      let placeholderAlpha: CGFloat = isCurrentSportActive ? 0.5 : 0.7
      
      currentSportButton.alpha = alpha
      currentSportLabel.realAlpha = alpha
      currentSportLabel.placeholderAlpha = placeholderAlpha
    }
  }
  
  var isSearchActive: Bool = false {
    didSet {
      searchButton.isEnabled = isSearchActive
      
      let alpha: CGFloat = isSearchActive ? 1 : 0.7
      searchButton.alpha = alpha
      searchLabel.alpha = alpha
    }
  }
  
  
}
