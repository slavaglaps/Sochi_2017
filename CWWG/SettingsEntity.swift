//
//  SettingsEntity.swift
//  CWWG
//
//  Created by Alexander Zimin on 25/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import Foundation
import RealmSwift

class SettingsEntity: Object, ObjectSingletone {
  dynamic var selectedLocalizationString: String?
  dynamic var lastWeatherId: Int = 0
  dynamic var lastWeatherDegree: Float = 0
}
