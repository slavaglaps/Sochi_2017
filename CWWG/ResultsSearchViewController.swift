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
  
  var fieldIndex: Int = 0
  
  @IBAction func sportButtonAction(_ sender: UIButton) {
    fieldIndex = 0
    self.performSegue(withIdentifier: "Select", sender: nil)
  }
  
  @IBAction func currentSportButtonAction(_ sender: UIButton) {
    fieldIndex = 1
    self.performSegue(withIdentifier: "Select", sender: nil)
  }
  
  @IBAction func searchButtonAction(_ sender: UIButton) {
    self.performSegue(withIdentifier: "Results", sender: nil)
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
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? SelectionViewController {
      destination.delegate = self
    }
    
    if let destination = segue.destination as? ResultsViewController {
      destination.sportString = selectedSport ?? ""
      destination.currentSportString = selectedCurrentSport ?? ""
    }
  }
  
}

extension ResultsSearchViewController: SelectionViewControllerDelegate {
  func selectionViewController(selectionViewController: SelectionViewController, didSelect element: String) {
    if fieldIndex == 0 {
      selectedSport = element
    } else {
      selectedCurrentSport = element
    }
  }
}
