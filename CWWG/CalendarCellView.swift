//
//  CalendarCellView.swift
//  CWWG
//
//  Created by Alexander Zimin on 04/02/2017.
//  Copyright © 2017 CWWG Team. All rights reserved.
//

import UIKit

class CalendarCellView: UIView {
  var buttonDidTouchAction: ((_ cell: CalendarCellView) -> ())?
  
  static func createCell(dayOfWeekString: String, date: Int, image: UIImage?) -> CalendarCellView {
    let cell = CalendarCellView.az_viewFromNib()
    
    cell.weekDateLabel.text = dayOfWeekString
    cell.dateLabel.text = "\(date)"
    cell.iconImageView.image = image
    
    return cell
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = AppColor.clear
    isSelected = false
  }
  
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var weekDateLabel: UILabel! {
    didSet {
      weekDateLabel.font = AppFont.latoRegularFont(ofSize: 12)
      weekDateLabel.textColor = AppColor.blue
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    dateBackgroundView.layer.cornerRadius = dateBackgroundView.frame.width / 2
  }
  
  @IBOutlet weak var dateBackgroundView: UIView!
  
  @IBOutlet weak var dateLabel: UILabel! {
    didSet {
      dateLabel.font = AppFont.latoRegularFont(ofSize: 15)
    }
  }
  
  var isSelected: Bool = false {
    didSet {
      if isSelected {
        dateLabel.textColor = AppColor.black
        dateBackgroundView.backgroundColor = AppColor.white
      } else {
        dateLabel.textColor = AppColor.white
        dateBackgroundView.backgroundColor = AppColor.clear
      }
    }
  }
  
  @IBAction func buttonTouchUpInsideAction(_ sender: UIButton) {
    buttonDidTouchAction?(self)
  }
  
}
