//
//  ResultsViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 18/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit
import Nuke
import RealmSwift

class ResultsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var placeLabel: UILabel!
  @IBOutlet weak var countryLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var scroreLabel: UILabel!
  
  var results: [ContestResultEntity] = []
  var events: Results<EventEntity>?
  
  var resultsId: Int = 0
  
  var sportString: String = ""
  var currentSportString: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for label in [placeLabel, countryLabel, nameLabel, scroreLabel] {
      label?.font = AppFont.latoRegularFont(ofSize: 13)
      label?.textColor = AppColor.lightBlue
    }
    
    placeLabel.text = Localizations.Results.Place
    countryLabel.text = Localizations.Results.Country
    nameLabel.text = Localizations.Results.Name
    scroreLabel.text = Localizations.Results.Score
    
    fill(with: sportString, additionalInfo: currentSportString)
    
    events = defaultRealm?.objects(EventEntity.self).filter("contestId == \(resultsId)").sorted(byKeyPath: #keyPath(EventEntity.startDate))
    
    NetworkRequestsController.requestContestResults(byId: resultsId) { [weak self] (results) in
      self?.results = results ?? []
      self?.tableView.reloadData()
    }
    // Do any additional setup after loading the view.
  }
  
  func fill(with sportName: String, additionalInfo: String) {
    let sportName = "\(sportName)\n"
    let attributedString = NSMutableAttributedString(string: "\(sportName)\(additionalInfo)")
    
    let subtitleRange = NSMakeRange(0, sportName.characters.count)
    let titleRange = NSMakeRange(sportName.characters.count, additionalInfo.characters.count)
    
    attributedString.addAttribute(NSForegroundColorAttributeName, value: AppColor.black, range: subtitleRange)
    attributedString.addAttribute(NSForegroundColorAttributeName, value: AppColor.gray, range: titleRange)
    attributedString.addAttribute(NSFontAttributeName, value: AppFont.latoRegularFont(ofSize: 17), range: subtitleRange)
    attributedString.addAttribute(NSFontAttributeName, value: AppFont.latoRegularFont(ofSize: 11), range: titleRange)
    
    let label = UILabel()
    label.numberOfLines = 2
    label.textAlignment = .center
    label.attributedText = attributedString
    
    label.sizeToFit()
    navigationItem.titleView = label
  }
  
  var isResultsEmpty: Bool {
    return results.isEmpty
  }
}

extension ResultsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isResultsEmpty {
      tableView.estimatedRowHeight = 66.0
      tableView.rowHeight = UITableViewAutomaticDimension
      return events?.count ?? 0
    } else {
      tableView.rowHeight = 66
      return results.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if isResultsEmpty {
      return self.tableView(tableView, eventCellForRowAt: indexPath)
    } else {
      return self.tableView(tableView, resultCellForRowAt: indexPath)
    }
  }
  
  func tableView(_ tableView: UITableView, eventCellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let event = events?.safeObject(atIndex: indexPath.row) else {
      assertionFailure("No event at index path: \(indexPath)")
      return UITableViewCell()
    }
    
    let object = ObjectRuntimeEntityContainer.findEntity(by: event.objectId)
    let eventType = event.eventType
    
    let cell = tableView.dequeueReusableCell(for: indexPath) as ScheduleTableViewCell
    
    cell.eventNameLabel.text = event.name
    cell.timeLabel.text = event.timeIntervalString
    
    cell.updateCellPosition(at: indexPath, inside: tableView)
    cell.setupWithPlace(nameString: object?.title ?? "")
    
    cell.timeLabelBackgroundView.backgroundColor = eventType.color
    cell.iconImageView.image = UIImage(named: eventType.imageName)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, resultCellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath) as ResultsViewTableViewCell
    
    let result = results[indexPath.row]
    
    cell.placeLabel.text = "\(result.place)"
    cell.nameLabel.text = result.name
    cell.scoresLabel.text = result.points
    
    if let url = URL(string: result.icon) {
      Nuke.loadImage(with: url, into: cell.countryImageView)
    }
    
    cell.updateCellPosition(at: indexPath, inside: tableView)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if let cell = cell as? ResultsViewTableViewCell {
      Nuke.cancelRequest(for: cell.countryImageView)
    }
  }
}
