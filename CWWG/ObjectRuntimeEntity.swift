//
//  ObjectRuntimeEntity.swift
//  CWWG
//
//  Created by Alexander Zimin on 30/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON

struct ObjectRuntimeEntityContainer {
  private static var _entities: [ObjectRuntimeEntity]? = nil
  static var entities: [ObjectRuntimeEntity] {
    if _entities == nil {
      loadEntities()
    }
    return _entities!
  }
  
  static func resetEntities() {
    _entities = nil
  }
  
  private static func loadEntities() {
    let path = Bundle.main.path(forResource: "Objects-\(LocalizationController.currentLocalization.rawValue)", ofType: "json")!
    let contentData = FileManager.default.contents(atPath: path)!
    let json = JSON(data: contentData)
    
    _entities = []
    
    for objectInfo in json.arrayValue {
      let title = objectInfo["title"].stringValue
      let subtitle = objectInfo["subtitle"].stringValue
      let size = objectInfo["size"].intValue
      let event = objectInfo["event"].stringValue
      let description = objectInfo["description"].stringValue
      let imageName = objectInfo["image_name"].stringValue
      
      let coordinatesComponents = objectInfo["location"].stringValue.components(separatedBy: ",")
      let coordinatesPair: (latitude: Double, longitude: Double)
      if let latitude = Double(coordinatesComponents.safeObject(atIndex: 0) ?? ""), let longitude = Double(coordinatesComponents.safeObject(atIndex: 1) ?? "") {
        coordinatesPair = (latitude, longitude)
      } else {
        assertionFailure("No coordinates info")
        coordinatesPair = (0, 0)
      }
      
      let entity = ObjectRuntimeEntity(title: title, subtitle: subtitle, description: description, size: size, event: event, imageName: imageName, latitude: coordinatesPair.latitude, longitude: coordinatesPair.longitude)
      _entities?.append(entity)
    }
  }
}

class ObjectRuntimeEntity {
  var title: String
  var subtitle: String
  var description: String
  var size: Int
  var imageName: String
  var event: String
  var coordinates: CLLocation
  
  var sizeString: String {
    return Localizations.ObjectPreview.Size(value1: size)
  }
  
  init(title: String, subtitle: String, description: String, size: Int, event: String, imageName: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
    self.title = title
    self.subtitle = subtitle
    self.description = description
    self.size = size
    self.event = event
    self.imageName = imageName
    self.coordinates = CLLocation(latitude: latitude, longitude: longitude)
  }
}
