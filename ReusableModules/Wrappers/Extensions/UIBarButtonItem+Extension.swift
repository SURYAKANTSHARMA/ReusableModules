//
//  UIBarButtonItem+Extension.swift
//  Driver
//
//  Created by Mac mini on 10/6/18.
//  Copyright © 2018 Mac mini. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    class func itemWith(colorfulImage: UIImage?, target: Any, action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(colorfulImage, for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0)
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }
}
