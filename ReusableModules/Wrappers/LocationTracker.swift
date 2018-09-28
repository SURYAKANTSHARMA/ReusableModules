//
//  LocationManager.swift
//  Rider
//
//  Created by Mac mini on 8/20/18.
//  Copyright © 2018 Mac mini. All rights reserved.
//

import Foundation
import CoreLocation

typealias LocateMeCallback = (_ location: CLLocation?) -> Void

class LocationTracker: NSObject {
    
    static let shared = LocationTracker()
    
    var lastLocation: CLLocation?
    
    var locationManager: CLLocationManager = {
       let locationManager = CLLocationManager()
       locationManager.activityType = .automotiveNavigation
       locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
       locationManager.distanceFilter = 10
      
       return locationManager
    }()
    
    var locateMeCallback: LocateMeCallback?
    var currentLocation: CLLocation?
    var isCurrentLocationAvailable: Bool {
        return currentLocation != nil
    }
    
    func enableLocationServices() {
        locationManager.delegate = self
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            // Disable location features
            print("Fail permission to get current location of user")
        case .authorizedWhenInUse:
            // Enable basic location features
            enableMyWhenInUseFeatures()
       case .authorizedAlways:
            // Enable any of your app's location features
            enableMyAlwaysFeatures()
       }
    }
    
    func enableMyWhenInUseFeatures() {
       locationManager.startUpdatingLocation()
       locationManager.delegate = self 
    }
    
    func enableMyAlwaysFeatures() {
       locationManager.allowsBackgroundLocationUpdates = true
       locationManager.pausesLocationUpdatesAutomatically = true
       locationManager.startUpdatingLocation()
       locationManager.delegate = self
    }
    
    func locateMe(callback: @escaping LocateMeCallback) {
        self.locateMeCallback = callback
        if lastLocation == nil {
            enableLocationServices()
        } else {
           callback(lastLocation)
        }
    }
    
    private override init() {}
}

// MARK: - CLLocationManagerDelegate
extension LocationTracker: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        guard let location = locations.first else { return }
        lastLocation = location
        print("locations = \(location.coordinate.latitude) \(location.coordinate.longitude)")
        locateMeCallback?(location)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        enableLocationServices()
    }
}
