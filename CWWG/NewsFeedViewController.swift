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
  
  enum UpdateDirection {
    case toNew
    case toOld
  }
  
  var news: Results<NewsEntity>?
  var notificationToken: NotificationToken? = nil
  
  var refreshControl: UIRefreshControl!
  
  @IBOutlet weak var tableView: UITableView!
  
  var bottomCell: UITableViewCell?
  var topCell: UITableViewCell?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addMenuButton()
    
    tableView.estimatedRowHeight = 181
    tableView.rowHeight = UITableViewAutomaticDimension
    
    news = defaultRealm?.objects(NewsEntity.self).sorted(byKeyPath: #keyPath(NewsEntity.dateOfCreation), ascending: false)
    notificationToken = news?.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
      OperationQueue.main.addOperation({ 
        self?.tableView.reloadData()
      })
    }
    
    updateFeed(inDirection: .toNew)
    
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(NewsFeedViewController.refreshFeed), for: .valueChanged)
    tableView.addSubview(refreshControl)
    
    NotificationCenter.default.addLanguageChangeObserver(observer: self)
  }
  
  deinit {
    print("Deinit")
  }
  
  func refreshFeed() {
    updateFeed(inDirection: .toNew)
  }
  
  func updateLanguage() {
    title = Localizations.MenuItem.News
    tableView.reloadData()
  }
  
  var isUpdateStarted = false
  var isUpdateOfUIStarted = false
  
  func updateFeed(inDirection: UpdateDirection) {
    if isUpdateStarted || isUpdateOfUIStarted {
      return
    }
    
    let id = inDirection == .toNew ? news?.first?.id : news?.last?.id
    
    isUpdateStarted = true
    NetworkRequestsController.requstNews(lastId: id ?? 0, limit: 10, ascending: inDirection == .toOld) {
      success in
      self.isUpdateStarted = false
      if self.refreshControl.isRefreshing {
        self.refreshControl.endRefreshing()
      }
      print("Request news, success: \(success)")
    }
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
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let percent = scrollView.contentOffset.y / (scrollView.contentSize.height - scrollView.frame.height)
    if percent > 0.8 {
       updateFeed(inDirection: .toOld)
    }
  }
}
