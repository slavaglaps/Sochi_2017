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
  
  let tableViewTopView = FashionLineView()
  let tableViewBottomView = FashionLineView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableViewTopView.tintColor = UIColor.lightGray
    tableViewBottomView.tintColor = UIColor.lightGray
    
    tableView.estimatedRowHeight = 44.0
    tableView.rowHeight = UITableViewAutomaticDimension
    
        tableView.addSubview(tableViewTopView)
    tableView.addSubview(tableViewBottomView)
    
    news = NewsRuntimeEntity.testData()
    // Do any additional setup after loading the view.
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    tableViewTopView.frame = CGRect(x: 0, y: -self.view.frame.height, width: 57, height: self.view.frame.height)
    tableViewBottomView.frame = CGRect(x: 0, y: self.view.frame.height, width: 57, height: self.view.frame.height)
  }
  
}

extension NewsFeedViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return news.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath) as NewsFeedPlainTableViewCell
    
    let currentNews = news[indexPath.row]
    cell.newsDescriptionLabel.text = currentNews.name
    cell.newsTimeLabel.text = currentNews.timeString
    
    return cell
  }
}
