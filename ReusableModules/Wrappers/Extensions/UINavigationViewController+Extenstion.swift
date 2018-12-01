//
//  UINavigationViewController+Extenstion.swift
//  YoGrowcerCustomer
//
//  Created by Mac mini on 6/29/18.
//  Copyright © 2018 SuryaKant Sharma. All rights reserved.
//

import UIKit

extension UINavigationController {
    var previousViewController: UIViewController? {
        let viewControllers = self.viewControllers
        return viewControllers[safe: self.viewControllers.count - 2]
    }
}


