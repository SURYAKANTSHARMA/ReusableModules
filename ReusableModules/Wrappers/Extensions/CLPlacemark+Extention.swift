//
//  CLPlacemark+Extention.swift
//  Rider
//
//  Created by Mac mini on 8/21/18.
//  Copyright © 2018 Mac mini. All rights reserved.
//

import Foundation
import CoreLocation

extension CLPlacemark {
    var compactAddress: String? {
        if let name = name {
            var result = name
            if let street = thoroughfare {
                result += ", \(street)"
            }
            if let city = locality {
                result += ", \(city)"
            }
            
            if let country = country {
                result += ", \(country)"
            }
            
            return result
        }
        return nil
    }
    
//    var displayAddress: String {
//        if let addressList =  self.addressDictionary?["FormattedAddressLines"] as? [String] {
//            return addressList.joined(separator: ", ")
//        }
//        return "Unknown"
//    }
//    
}


