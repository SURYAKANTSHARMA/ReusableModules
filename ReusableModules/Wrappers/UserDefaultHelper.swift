//
//  UserDefaultHelper.swift
//  Rider
//
//  Created by Mac mini on 10/5/18.
//  Copyright © 2018 Mac mini. All rights reserved.
//

import UIKit

private enum Defaults: String {
    case sampleKey = "sampleKey"
   
}

final class UserDefaultHelper {
    
    static var sampleKey: String? {
        set{
            _set(value: newValue, key: .sampleKey)
        } get {
            return _get(valueForKay: .sampleKey) as? String
        }
    }
    
    private static func _set(value: Any?, key: Defaults) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
    
    private static func _get(valueForKay key: Defaults)-> Any? {
        return UserDefaults.standard.value(forKey: key.rawValue)
    }
    
    private static func _delete(valueForKay key: Defaults) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    static func deleteCountryCode() {
        UserDefaults.standard.removeObject(forKey: Defaults.sampleKey.rawValue)
    }
    
}
