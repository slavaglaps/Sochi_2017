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
      schemeString = "comgooglemaps://?q=\(location.coordinate.latitude),\(location.coordinate.longitude)"
    case .yandexMaps:
      schemeString = "yandexmaps://maps.yandex.ru/?pt=\(location.coordinate.latitude),\(location.coordinate.longitude)"
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
  @IBOutlet weak var mapView: MKMapView!
  
  var maps: [MapAppType] = []
  var object: ObjectRuntimeEntity!
  
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
      guard let stongSelf = self else {
        return
      }
      let map = stongSelf.maps[index]
      let coordinates = stongSelf.object.coordinates.coordinate
      let scheme = map.scheme(with: CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude))
      UIApplication.shared.openURL(scheme)
    }
    
    if maps.count == 0 {
      openInView.isHidden = true
    }
    
    let coordinates = object.coordinates.coordinate
    let center = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    mapView.setRegion(region, animated: true)
    
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
