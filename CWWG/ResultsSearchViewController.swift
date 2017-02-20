//
//  ResultsSearchViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 18/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit
import RealmSwift

class ResultsSearchViewController: UIViewController, UpdateLanguageNotificationObserver {
  
  @IBOutlet weak var sportButton: UIButton!
  @IBOutlet weak var currentSportButton: UIButton!
  @IBOutlet weak var searchButton: UIButton!
  
  @IBOutlet weak var sportLabel: PlaceholderLabel!
  @IBOutlet weak var currentSportLabel: PlaceholderLabel!
  @IBOutlet weak var searchLabel: UILabel!
  
  @IBOutlet var allMedalsButton: UIButton! {
    didSet {
      allMedalsButton.titleLabel?.font = AppFont.latoRegularFont(ofSize: 14)
    }
  }
  
  
  var events: Results<EventTypeEntity>?
  var contests: List<ContestEntity>?
  
  var selectedSport: EventTypeEntity? = nil {
    didSet {
      selectedCurrentSport = nil
      isCurrentSportActive = selectedSport != nil
      sportLabel.textString = selectedSport?.name
      contests = selectedSport?.contests
    }
  }
  
  var selectedCurrentSport: ContestEntity? {
    didSet {
      isSearchActive = selectedCurrentSport != nil
      currentSportLabel.textString = selectedCurrentSport?.name
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for label in [sportLabel, currentSportLabel, searchLabel] {
      label?.textColor = AppColor.black
      label?.font = AppFont.latoRegularFont(ofSize: 14)
    }
    
    isSportActive = true

    addMenuButton()
    NotificationCenter.default.addLanguageChangeObserver(observer: self)
    
    checkIfNeedToUpdateSport()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func checkIfNeedToUpdateSport() {
    if events?.isEmpty == true {
      isSportActive = false
      NetworkRequestsController.requestEvents { [weak self] (success) in
        if success && self?.events?.isEmpty == false {
          self?.isSportActive = true
        }
      }
    }
  }
  
  @IBAction func allMedalsButtonActon(_ sender: UIButton) {
    let webController = ViewControllersFactory.webViewController
    webController.type = .members
    self.navigationController?.pushViewController(webController, animated: true)
  }
  
  func updateLanguage() {
    events = defaultRealm?.objects(EventTypeEntity.self)
    
    title = Localizations.MenuItem.Results
    
    sportLabel.placeholderAlpha = 0.8
    
    sportLabel.placeholderString = Localizations.ResultSearch.Sport
    currentSportLabel.placeholderString = Localizations.ResultSearch.Competition
    searchLabel.text = Localizations.ResultSearch.Search
    
    selectedSport = nil
    checkIfNeedToUpdateSport()
    
    allMedalsButton.setTitle(Localizations.Results.WhoIs, for: .normal)
  }
  
  var fieldIndex: Int = 0
  
  @IBAction func sportButtonAction(_ sender: UIButton) {
    fieldIndex = 0
    self.performSegue(withIdentifier: "Select", sender: 1)
  }
  
  @IBAction func currentSportButtonAction(_ sender: UIButton) {
    fieldIndex = 1
    self.performSegue(withIdentifier: "Select", sender: 2)
  }
  
  @IBAction func searchButtonAction(_ sender: UIButton) {
    self.performSegue(withIdentifier: "Results", sender: nil)
  }
  
  var isSportActive: Bool = false {
    didSet {
      sportButton.isEnabled = isSportActive
      
      let alpha: CGFloat = isSportActive ? 1 : 0.7
      let placeholderAlpha: CGFloat = isSportActive ? 0.5 : 0.7
      
      sportButton.alpha = alpha
      sportLabel.realAlpha = alpha
      sportLabel.placeholderAlpha = placeholderAlpha
    }
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
      if let tag = sender as? Int {
        if tag == 1 {
          destination.elemets = events?.map({ $0 }) ?? []
        } else {
          destination.elemets = contests?.map({ $0 }) ?? []
        }
      }
      destination.delegate = self
    }
    
    if let destination = segue.destination as? ResultsViewController {
      destination.sportString = selectedSport?.name ?? ""
      destination.currentSportString = selectedCurrentSport?.name ?? ""
      destination.resultsId = selectedCurrentSport?.id ?? 0
    }
  }
  
}

extension ResultsSearchViewController: SelectionViewControllerDelegate {
  func selectionViewController(selectionViewController: SelectionViewController, didSelect element: SelectionEntity) {
    if fieldIndex == 0 {
      selectedSport = element as? EventTypeEntity
    } else {
      selectedCurrentSport = element as? ContestEntity
    }
  }
}
