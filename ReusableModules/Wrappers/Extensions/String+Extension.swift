//
//  String+Extension.swift
//  App
//
//  Created by cl-macmini-68 on 09/12/16.
//  Copyright © 2016 Suryakant Sharma. All rights reserved.
//

import Foundation
import UIKit

// MARK:- 


extension String {
    
    // Return ISO fromated date.
    var dateFromISO8601: Date? {
        return Date.Formatter.iso8601.date(from: self)
    }
    
    var daySuffix: String {
        if (self == "11" || self == "12" || self == "13"){
            return "th"
        }
        let lastChar: Character =  self[self.index(before: self.endIndex)]
        switch lastChar {
        case "1":
            return self.appending("st");
        case "2":
            return self.appending("nd");
        case "3":
            return self.appending("rd");
        default:
            return self.appending("th");
        }
    }
    
    

    // Character count
    public var length: Int {
        return self.count
    }
    
    public var countofWords: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+", options: NSRegularExpression.Options())
        return regex?.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: self.length)) ?? 0
    }
    
    // Checks if string is empty or consists only of whitespace and newline characters
    public var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmed.isEmpty
        }
    }
    
    // Trims white space and new line characters, returns a new string
    public func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // Trims white space and new line characters
    public mutating func trim() {
        self = self.trimmed()
    }
    
    // Capitalizes first character of String, returns a new string
    public func capitalizedFirst() -> String {
        guard count > 0 else { return self }
        var result = self
        result.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).capitalized)
        return result
    }
    
    //Returns if String is a number
    public func isNumber() -> Bool {
        if let _ = NumberFormatter().number(from: self) {
            return true
        }
        return false
    }
    
    //URL encode a string (percent encoding special chars)
    public func urlEncoded() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    //URL encode a string (percent encoding special chars) mutating version
    mutating func urlEncode() {
        self = urlEncoded()
    }


    var isValidEmail: Bool {
        let emailRegExp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegExp)
        return emailTest.evaluate(with: self)
    }
    
    var swifty: String {
       return self.replacingOccurrences(of: "&amp;", with: "&")
    }
    
    var addLeftPadding: String {
        return " " + self
    }
    var addLeftLargePadding: String {
        return "   " + self
    }
    var addRightLargePadding: String {
        return  self  + "   "
    }
   
}


