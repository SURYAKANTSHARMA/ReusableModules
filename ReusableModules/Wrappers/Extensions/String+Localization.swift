//
//  String+Localization.swift
//  KurdTaxi
//
//  Created by Cl-macmini-100 on 6/12/17.
//  Copyright © 2017 Click Lab 100. All rights reserved.
//

import Foundation

public extension String {
  
  /**
   - parameter tableName: The receiver’s string table to search. If tableName is `nil`
   or is an empty string, the method attempts to use `Localizable.strings`.
   
   - parameter bundle: The receiver’s bundle to search. If bundle is `nil`,
   the method attempts to use main bundle.
   
   - returns: The localized string.
   */
  
   func localized(using tableName: String?, in bundle: Bundle?) -> String {
    let bundle: Bundle = bundle ?? .main
    if let path = bundle.path(forResource: Localize.currentLanguage(), ofType: "lproj"),
      let bundle = Bundle(path: path) {
      return bundle.localizedString(forKey: self, value: nil, table: tableName)
    }
    return self
  }
  
  /**
   - Default localization.
  */
 var localized: String {
    let bundle: Bundle = .main
    if let path = bundle.path(forResource: Localize.currentLanguage(), ofType: "lproj"),
      let bundle = Bundle(path: path) {
      return bundle.localizedString(forKey: self, value: "", table: nil)
    }
 
    return self
  }
  
}




