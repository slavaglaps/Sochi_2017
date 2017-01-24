//
//  NewsPreviewViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 18/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class NewsPreviewViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var currentNews: NewsRuntimeEntity!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.estimatedRowHeight = 44.0
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  @IBAction func openMenuButtonAction(_ sender: UIBarButtonItem) {
    let menuViewController = ViewControllersFactory.menuViewController
    self.present(menuViewController, animated: true, completion: nil)
  }
  
}

extension NewsPreviewViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 { // Header
      let cell = tableView.dequeueReusableCell(for: indexPath) as NewsFeedImageTableViewCell
      
      if currentNews.isWithImage {
        // FIXME: - Implement
      } else {
        cell.gradientImageView.image = nil
        cell.gradientImageView.backgroundColor = AppColor.emptyHeaderBlue
      }
      
      cell.newsDescriptionLabel.text = currentNews.name
      cell.newsTimeLabel.text = currentNews.timeString
      
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(for: indexPath) as NewsPreviewDescriptionTableViewCell
      cell.newsDescriptionLabel.text = currentNews.desctiption
      return cell
    }
  }
}

extension NewsPreviewViewController: UITableViewDelegate {
  
}
