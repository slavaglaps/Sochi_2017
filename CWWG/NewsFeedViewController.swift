//
//  NewsFeedViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 18/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit
import Nuke
import RealmSwift

class NewsFeedViewController: UIViewController, UpdateLanguageNotificationObserver {
  
  var news: Results<NewsEntity>?
  var notificationToken: NotificationToken? = nil
  
  @IBOutlet weak var tableView: UITableView!
  
  var bottomCell: UITableViewCell?
  var topCell: UITableViewCell?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.estimatedRowHeight = 44.0
    tableView.rowHeight = UITableViewAutomaticDimension
    
    RouterController.shared.baseNavigationController = self.navigationController
    
    news = defaultRealm?.objects(NewsEntity.self).sorted(byKeyPath: #keyPath(NewsEntity.dateOfCreation), ascending: false)
    notificationToken = news?.addTableObserver(tableView: tableView)
    
    NetworkRequestsController.requstNews(lastId: 0, limit: 10) {
      success in
      print("Request news, success: \(success)")
    }
    
    NotificationCenter.default.addLanguageChangeObserver(observer: self)
  }
  
  @IBAction func openMenuButtonAction(_ sender: UIBarButtonItem) {
    let menuViewController = ViewControllersFactory.menuViewController
    self.present(menuViewController, animated: true, completion: nil)
  }
  
  func updateLanguage() {
    title = Localizations.News.Title
    tableView.reloadData()
  }
  
}

extension NewsFeedViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return news?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let currentNews = news![indexPath.row]
    
    if currentNews.isWithImage {
      let cell = tableView.dequeueReusableCell(for: indexPath) as NewsFeedImageTableViewCell
      
      cell.newsDescriptionLabel.text = currentNews.title
      cell.newsTimeLabel.text = currentNews.timeString
      
      Nuke.loadImage(with: URL(string: currentNews.imageURL!)!, into: cell.newsImageView)
      
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(for: indexPath) as NewsFeedPlainTableViewCell
      
      cell.newsDescriptionLabel.text = currentNews.title
      cell.newsTimeLabel.text = currentNews.timeString
      
      if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 { // If last
        (bottomCell as? NewsFeedPlainTableViewCell)?.position = .normal
        cell.position = .bottom
        bottomCell = cell
      } else if indexPath.row == 0 { // If first
        (topCell as? NewsFeedPlainTableViewCell)?.position = .normal
        cell.position = .top
        topCell = cell
      } else {
        cell.position = .normal
      }
      
      return cell
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? NewsPreviewViewController, let indexPath = sender as? IndexPath {
      let currentNews = news![indexPath.row]
      destination.currentNews = currentNews
    }
  }
}

extension NewsFeedViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if let cell = cell as? NewsFeedImageTableViewCell {
      Nuke.cancelRequest(for: cell.newsImageView)
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    self.performSegue(withIdentifier: "Preview", sender: indexPath)
  }
}
