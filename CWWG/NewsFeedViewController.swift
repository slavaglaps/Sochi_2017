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
    
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(NewsFeedViewController.refreshFeed), for: .valueChanged)
    tableView.addSubview(refreshControl)
    
    NotificationCenter.default.addLanguageChangeObserver(observer: self)
  }
  
  func refreshFeed() {
    updateFeed(inDirection: .toNew)
  }
  
  func updateLanguage() {
    shouldLoadOldNewsInCount = 0
    
    news = defaultRealm?.objects(NewsEntity.self).sorted(byKeyPath: #keyPath(NewsEntity.dateOfCreation), ascending: false)
    
    title = Localizations.MenuItem.News
    
    updateFeed(inDirection: .toNew)
    tableView.reloadData()
    
    shouldUpdateToOldData = true
  }
  
  var isUpdateStarted = false
  var shouldLoadOldNewsInCount = 0
  var isUpdateOfUIStarted = false
  var shouldUpdateToOldData = true
  
  func updateFeed(inDirection: UpdateDirection) {
    if isUpdateStarted || isUpdateOfUIStarted {
      return
    }
    
    if inDirection == .toOld && shouldUpdateToOldData == false {
      return
    }
    
    if inDirection == .toOld {
      shouldLoadOldNewsInCount -= 1
    }
    
    let onlyNewNews = defaultRealm?.objects(NewsEntity.self).filter("isInCurrentSession == true").sorted(byKeyPath: #keyPath(NewsEntity.dateOfCreation), ascending: false)
    let id = inDirection == .toNew ? onlyNewNews?.first?.id : onlyNewNews?.last?.id
    
    isUpdateStarted = true
    NetworkRequestsController.requstNews(lastId: id ?? 0, limit: 10, ascending: inDirection == .toOld) { [weak self]
      (success, isNewData) in
      guard let strongSelf = self else { return }
      
      strongSelf.isUpdateStarted = false
      if strongSelf.refreshControl.isRefreshing {
        strongSelf.refreshControl.endRefreshing()
      }
      
      if isNewData {
        strongSelf.tableView.reloadData()
      }
      
      if success && isNewData == false && inDirection == .toOld {
        strongSelf.shouldUpdateToOldData = false
      }
      
      if strongSelf.shouldLoadOldNewsInCount > 0 {
        strongSelf.updateFeed(inDirection: .toOld)
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
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let percent = CGFloat(indexPath.row) / CGFloat(tableView.numberOfRows(inSection: 0))
    let currentNews = news![indexPath.row]
    if percent > 0.8 || currentNews.isInCurrentSession == false {
      shouldLoadOldNewsInCount += 1
      updateFeed(inDirection: .toOld)
    }
  }
  
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if let cell = cell as? NewsFeedImageTableViewCell {
      Nuke.cancelRequest(for: cell.newsImageView)
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    self.performSegue(withIdentifier: "Preview", sender: indexPath)
  }
  
//  func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    let percent = scrollView.contentOffset.y / (scrollView.contentSize.height - scrollView.frame.height)
//    if percent > 0.8 {
//       updateFeed(inDirection: .toOld)
//    }
//  }
}
