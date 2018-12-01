//
//  UIKit+Localized.swift
//  YoGrowcerCustomer
//
//  Created by Mac mini on 5/24/18.
//  Copyright © 2018 SuryaKant Sharma. All rights reserved.
//

import UIKit

import UIKit

public func LocalizedString(_ key: String, comment: String) -> String {
    let localText = NSLocalizedString(key, comment: "")
    return localText == key ? comment :  localText
}

extension UIButton {
    
    @IBInspectable
    var local_title: String? {
        get {
            return ""
        }
        set {
            guard let text = newValue, !text.isEmpty else {
                return
            }
            let localText = LocalizedString(text, comment: text)
            if localText != text {
                self.setTitle(localText, for: UIControl.State.normal)
            }
        }
    }
}

extension UILabel {
    @IBInspectable
    var local_title: String? {
        get {
            return ""
        }
        set {
            guard let text = newValue, !text.isEmpty else {
                return
            }
            let localText = LocalizedString(text, comment: text)
            if localText != text {
                self.text = localText
            }
        }
    }
}

extension UITextField {
    
    @IBInspectable
    var local_placeholder: String? {
        get {
            return ""
        }
        set {
            guard let text = newValue, !text.isEmpty else {
                return
            }
            let localText = LocalizedString(text, comment: text)
            if localText != text {
                self.placeholder = localText
            }
        }
    }
    
}

extension UINavigationItem {
    
    @IBInspectable
    var local_title: String? {
        get {
            return ""
        }
        set {
            guard let text = newValue, !text.isEmpty else {
                return
            }
            let localText = LocalizedString(text, comment: text)
            if localText != text {
                self.title = localText
            }
        }
    }
    
}

