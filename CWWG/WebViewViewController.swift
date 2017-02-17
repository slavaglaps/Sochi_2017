//
//  WebViewViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 09/02/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class WebViewViewController: UIViewController {
  
  enum `Type` {
    case cism
    case members
    case custom(url: URL, title: String)
    
    var fileName: String {
      switch self {
      case .cism:
        return "CISM_\(LocalizationController.currentLocalization.serverString)"
      case .members:
        return "CISM_countries_\(LocalizationController.currentLocalization.serverString)"
      case .custom(_, _):
        fatalError("Should not be reached")
      }
    }
    
    var title: String {
      switch self {
      case .cism:
        return Localizations.MenuItem.AboutCism
      case .members:
        return Localizations.Results.WhoIs
      case .custom(_, let title):
        return title
      }
    }
  }
  
  @IBOutlet var webView: UIWebView!
  var type: Type = .cism
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = type.title
    
    switch type {
    case .cism, .members:
      openPdfFile()
    case .custom(let url, _):
      openURL(url: url)
    }
    
    if navigationController?.viewControllers.count == 1 {
      addMenuButton()
    }
  }
  
  func openPdfFile() {
    if let pdfURL = Bundle.main.url(forResource: type.fileName, withExtension: "pdf", subdirectory: nil, localization: nil)  {
      do {
        let data = try Data(contentsOf: pdfURL)
        webView.load(data, mimeType: "application/pdf", textEncodingName:"", baseURL: pdfURL.deletingLastPathComponent())
        // webView.scalesPageToFit = true
      }
      catch { }
    }
  }
  
  func openURL(url: URL) {
    let requst = URLRequest(url: url)
    webView.loadRequest(requst)
  }
  
}
