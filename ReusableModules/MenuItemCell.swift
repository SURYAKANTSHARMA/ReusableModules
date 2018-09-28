//
//  MenuItemCell.swift
//  YoGrowcerCustomer
//
//  Created by Mac mini on 5/24/18.
//  Copyright © 2018 SuryaKant Sharma. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.Application.lightThemeColor
    }

}
