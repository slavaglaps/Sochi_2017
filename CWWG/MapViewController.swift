//
//  MapViewController.swift
//  CWWG
//
//  Created by Alexander Zimin on 18/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

enum MapAppType {
  case googleMaps
  case yandexMaps
  case yandexNavigation
  
  var title: String {
    switch self {
    case .googleMaps:
      return "Google Maps"
    case .yandexMaps:
      return "Yandex Maps"
    case .yandexNavigation:
      return "Yandex Navigation"
    }
  }
  
  var scheme: URL {
    // UIApplication.shared.openURL(URL(string: "comgooglemaps://?center=40.765819,-73.975866&zoom=14&views=traffic")!)
    // yandexmaps://maps.yandex.ru/?ll=37.5959049,55.7390474&z=12
    // yandexnavi://build_route_on_map?lat_to=55.758192&lon_to=37.642817
    let schemeString: String
    switch self {
    case .googleMaps:
      schemeString = "comgooglemaps://"
    case .yandexMaps:
      schemeString = "yandexmaps://"
    default:
      schemeString = "yandexnavi://"
    }
    return URL(string: schemeString)!
  }
  
  func scheme(with location: CLLocation) -> URL {
    let schemeString: String
    switch self {
    case .googleMaps:
      schemeString = "comgooglemaps://?center=\(location.coordinate.latitude),\(location.coordinate.longitude)"
    case .yandexMaps:
      schemeString = "yandexmaps://maps.yandex.ru/?ll=\(location.coordinate.latitude),\(location.coordinate.longitude)"
    default:
      schemeString = "yandexnavi://build_route_on_map?lat_to=\(location.coordinate.latitude)&lon_to=\(location.coordinate.longitude)"
    }
    return URL(string: schemeString)!
  }
  
  var canOpen: Bool {
    return UIApplication.shared.canOpenURL(scheme)
  }
  
  static var allMaps: [MapAppType] = [.googleMaps, .yandexMaps, .yandexNavigation]
}

class MapViewController: UIViewController, UpdateLanguageNotificationObserver {
  
  @IBOutlet weak var openInView: OpenInButtonsView!
  var maps: [MapAppType] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for map in MapAppType.allMaps {
      if map.canOpen {
        maps.append(map)
      }
    }
    
    openInView.setupWithButtons(titles: maps.map({ $0.title }))
    
    openInView.buttonDidTapAt = {
      [weak self] index in
      guard let map = self?.maps[index] else {
        return
      }
      let scheme = map.scheme(with: CLLocation(latitude: 20, longitude: 30))
      UIApplication.shared.openURL(scheme)
    }
    
    if maps.count == 0 {
      openInView.isHidden = true
    }
    
    NotificationCenter.default.addLanguageChangeObserver(observer: self)
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func updateLanguage() {
    self.title = Localizations.Map.Title
  }
  
  
}
