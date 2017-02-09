//
//  AlertViewHelper.swift
//  CWWG
//
//  Created by Alexander Zimin on 09/02/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class AlertViewHelper {
  static func showAlertView(with title: String, message: String, buttonTitle: String, fromViewController: UIViewController) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let defaultAction = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
    alertController.addAction(defaultAction)
    
    fromViewController.present(alertController, animated: true, completion: nil)
  }
}
