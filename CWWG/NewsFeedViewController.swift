//
//  NewsFeedViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 18/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {
  
  var news: [NewsRuntimeEntity] = []
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    tableView.estimatedRowHeight = 44.0
    tableView.rowHeight = UITableViewAutomaticDimension
    
    news = NewsRuntimeEntity.testData()
    // Do any additional setup after loading the view.
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }
  
}

extension NewsFeedViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return news.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let currentNews = news[indexPath.row]
    let isImage = currentNews.imageURL != nil
    
    if isImage {
      let cell = tableView.dequeueReusableCell(for: indexPath) as NewsFeedImageTableViewCell
      
      let currentNews = news[indexPath.row]
      cell.newsDescriptionLabel.text = currentNews.name
      cell.newsTimeLabel.text = currentNews.timeString
      
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(for: indexPath) as NewsFeedPlainTableViewCell
      
      let currentNews = news[indexPath.row]
      cell.newsDescriptionLabel.text = currentNews.name
      cell.newsTimeLabel.text = currentNews.timeString
      
      if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 { // If last
        cell.position = .bottom
      } else if indexPath.row == 0 { // If first
        cell.position = .top
      } else {
        cell.position = .normal
      }
      
      return cell
    }
  }
}
