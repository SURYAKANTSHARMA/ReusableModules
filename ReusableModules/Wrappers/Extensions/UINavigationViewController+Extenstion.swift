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
    
    func popToVC<T: UIViewController>(kind: T.Type) {
        for vc in viewControllers {
            if let _ = vc as? T {
                _ = self.popToViewController(vc, animated: true)
                return
            }
        }
    }
    
}


