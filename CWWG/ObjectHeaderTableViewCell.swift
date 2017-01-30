//
//  ObjectHeaderTableViewCell.swift
//  CWWG
//
//  Created by Alexander Zimin on 30/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class ObjectHeaderTableViewCell: UITableViewCell, Reusable {
  
  @IBOutlet weak var objectImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
