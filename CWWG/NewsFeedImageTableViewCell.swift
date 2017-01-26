//
//  NewsFeedImageTableViewCell.swift
//  CWWG
//
//  Created by Alexander Zimin on 24/01/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class NewsFeedImageTableViewCell: UITableViewCell, Reusable {
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.newsImageView.image = UIImage(named: "img_tempalte")
  }
  
  @IBOutlet weak var newsImageView: UIImageView!
  @IBOutlet weak var gradientImageView: UIImageView!
  
  @IBOutlet weak var newsDescriptionLabel: UILabel! {
    didSet {
      newsDescriptionLabel.textColor = AppColor.white
      newsDescriptionLabel.font = AppFont.latoRegularFont(ofSize: 15)
      newsDescriptionLabel.numberOfLines = 4
    }
  }
  
  @IBOutlet weak var newsTimeLabel: UILabel! {
    didSet {
      newsTimeLabel.textColor = AppColor.white.withAlphaComponent(0.6)
      newsTimeLabel.font = AppFont.latoRegularFont(ofSize: 11)
    }
  }
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
