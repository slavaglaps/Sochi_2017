//
//  ScheduleViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 18/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var events: [EventEntity] = []
  
  @IBOutlet weak var calendarStackView: UIStackView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    events = EventEntity.fakeData()
    
    addMenuButton()
    
    tableView.rowHeight = 120
    
    for i in 0..<7 {
      let cell = CalendarCellView.createCell(dayOfWeekString: "5", date: 27)
      calendarStackView.addArrangedSubview(cell)
    }
    
    // Do any additional setup after loading the view.
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? ObjectPreviewViewController, let object = sender as? ObjectRuntimeEntity {
      destination.object = object
    }
  }
}

extension ScheduleViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return events.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let event = events[indexPath.row]
    let object = ObjectRuntimeEntityContainer.findEntity(by: event.objectId)
    
    let cell = tableView.dequeueReusableCell(for: indexPath) as ScheduleTableViewCell
    
    cell.eventNameLabel.text = event.name
    cell.timeLabel.text = event.timeIntervalString
    
    cell.updateCellPosition(at: indexPath, inside: tableView)
    cell.setupWithPlace(nameString: object?.title ?? "")
    
    return cell
  }
}

extension ScheduleViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let event = events[indexPath.row]
    let object = ObjectRuntimeEntityContainer.findEntity(by: event.objectId)
    
    if let object = object {
      self.performSegue(withIdentifier: "Object", sender: object)
    }
  }
}

