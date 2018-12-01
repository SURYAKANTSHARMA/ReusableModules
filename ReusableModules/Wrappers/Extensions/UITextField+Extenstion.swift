//
//  UITextField+Extenstion.swift
//  YoGrowcerCustomer
//
//  Created by IOS Developer on 15/05/18.
//  Copyright © 2018 SuryaKant Sharma. All rights reserved.
//

import UIKit

extension  UITextField {
    
    func placeHolderColor(color: UIColor!) {
        if (self.placeholder != nil) {
            let attriStr =  NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: color])
            self.attributedPlaceholder = attriStr
        }
    }
    
    func addLeftImageButton(image: UIImage, action: (()-> Void)? = nil) {
        
        let button = SwiftyButton(type: .custom)
        button.setImage(image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(0), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.action = action
        
        leftView = button
        leftViewMode = .always
    }
    
    func addRightImageButton(image: UIImage, action: (()-> Void)? = nil) {
        
        let button = SwiftyButton(type: .custom)
        button.setImage(image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(0), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.action = action
        
        rightView = button
        rightViewMode = .always
    }
}

