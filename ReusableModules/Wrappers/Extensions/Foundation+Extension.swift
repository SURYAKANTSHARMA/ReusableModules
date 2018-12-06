//
//  Collection+Extension.swift
//  App
//
//  Created by Cl-macmini-100 on 3/29/17.
//  Copyright © 2017 Suryakant. All rights reserved.
//

import Foundation

extension String {
  func toInt() -> Int? {
    return Int(self)
  }
}

extension Date {
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
    
    struct Formatter {
        static let iso8601: DateFormatter = {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            //formatter.timeZone = TimeZone(secondsFromGMT: 0)
            //formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            return formatter
        }()
    }
    
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
}

extension Int {
    var toString: String {
        return "\(self)"
    }
    
    var toBool: Bool {
        return self == 1
    }
    
    var isGreaterThanZero: Bool {
        return self > 0
    }
}

extension Float {
    var toString: String {
        return "\(Int(self))"
    }
}

extension Double {
    
    var toString: String {
        if self ==  Double(Int(self)) {
            return  "\(Int(self))"
        } else {
            return "\(self)"
        }
    }
    
    var nonZero: Bool {
        return self != 0.0
    }
    
    var toInt: Int {
        return Int(self)
    }
    
    var upToTwoDecimalPlace: Double {
        return (self * 100).rounded() / 100
    }

}

extension Int {
    var isSuccess: Bool {
        return self == 1
    }
    var isFailure: Bool {
        return self == 0
    }
    var nonZero: Bool {
        return self != 0
    }
}

extension Bool {
    var toInt: Int {
        return self == true ? 1 : 0
    }
}

extension String {
    var toBool: Bool {
        if self == "1" {
            return true
        } else if self == "0" {
            return false
        } else {
          fatalError("Unknown type")
        }
    }
   
    var fileExtension: String? {
        guard let idx = index(of: ".") else {
            return nil
        }
        let extenstionStart = index(after: idx)
        return String(self[extenstionStart...])
    }
}




extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}


extension Dictionary where Key == String, Value: Any {
    subscript (canBeString key: Key) -> Int? {
        if let value = self[key] as? Int {
            return value
        } else if let valueString = self[key] as? String, let value = Int(valueString) {
            return value
        }
      return nil
    }
    /*
     Developer assume that in whatever form value is may be string format or may be int format can be convert to integer finally. Otherwise return NIL.
     **/
    func stringOrInt(key: String) -> Int? {
        if let value = self[key] as? Int {
            return value
        } else if let valueString = self[key] as? String, let value = Int(valueString) {
            return value
        }
        return nil
    }
    func stringOrDouble(key: String) -> Double? {
        if let value = self[key] as? Double {
            return value
        } else if let valueString = self[key] as? String, let value = Double(valueString) {
            return value
        }
        return nil
    }
    var firstKeyObject: Any? {
        guard let firstKey = self.keys.first else {
            return nil
        }
        return self[firstKey]
    }
}



