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
    case military
    
    var fileName: String {
      switch self {
      case .cism:
        return "CISM_\(LocalizationController.currentLocalization.serverString)"
      case .military:
        fatalError("Militart")
      }
    }
  }
  
  @IBOutlet var webView: UIWebView!
  var type: Type = .cism
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let pdfURL = Bundle.main.url(forResource: type.fileName, withExtension: "pdf", subdirectory: nil, localization: nil)  {
      do {
        let data = try Data(contentsOf: pdfURL)
        webView.load(data, mimeType: "application/pdf", textEncodingName:"", baseURL: pdfURL.deletingLastPathComponent())
        // webView.scalesPageToFit = true
      }
      catch { }
    }
    
    addMenuButton()
  }
  
}
