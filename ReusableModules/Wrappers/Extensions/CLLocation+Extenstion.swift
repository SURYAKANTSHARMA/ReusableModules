//
//  CLLocation+Extenstion.swift
//  Rider
//
//  Created by Mac mini on 8/21/18.
//  Copyright © 2018 Mac mini. All rights reserved.
//

import Foundation
import CoreLocation


extension CLLocation {
    func getDisplayLocation(callback: @escaping ((_ address: String) -> Void)) {
        CLGeocoder().reverseGeocodeLocation(self) { placeMarks, error in
            if let error = error {
                print("Reverse geocoder failed with error" + error.localizedDescription)
                callback("Unknown")
                return
            }
            if let placeMarks = placeMarks, !placeMarks.isEmpty {
                let placemark = placeMarks.first!
                callback(placemark.compactAddress ?? "Unknown")
            }
        }
    }
    
    static func getCoordinates(fromDisplayLocation displayLocation: String,
                               callBack: @escaping (_ location: CLLocation?) -> Void) {
        CLGeocoder().geocodeAddressString(displayLocation) { placemarks, error in
            guard let placemarks = placemarks,
                let location = placemarks.first?.location else {
                    callBack(nil)
                    return
            }
           callBack(location)
        }
    }
    
    
}

extension CLLocationCoordinate2D {
    
    func bearing(to point: CLLocationCoordinate2D) -> Double {
        func degreesToRadians(_ degrees: Double) -> Double { return degrees * Double.pi / 180.0 }
        func radiansToDegrees(_ radians: Double) -> Double { return radians * 180.0 / Double.pi }
        
        let lat1 = degreesToRadians(latitude)
        let lon1 = degreesToRadians(longitude)
        
        let lat2 = degreesToRadians(point.latitude);
        let lon2 = degreesToRadians(point.longitude);
        
        let dLon = lon2 - lon1;
        
        let y = sin(dLon) * cos(lat2);
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
        let radiansBearing = atan2(y, x);
        
        return radiansToDegrees(radiansBearing)
    }
    
}
