////
////  GMSMapView+Extension.swift
////  FabU
////
////  Created by Cl-macmini-100 on 5/2/17.
////  Copyright © 2017 Aditya Aggarwal. All rights reserved.
//
//
//import Foundation
//import GoogleMaps
//let kPadding: CGFloat = 115
//
//extension GMSMapView {
//
//    func drawPath(_ encodedPathString: String, adjustToFit: Bool) {
//
//    CATransaction.begin()
//    CATransaction.setAnimationDuration(0.0)
//    let path = GMSPath(fromEncodedPath: encodedPathString)
//    
//    //adjust map to view all markers
//    if adjustToFit {
//        let bounds = GMSCoordinateBounds(path: path ?? GMSPath())
//        animate(with: GMSCameraUpdate.fit(bounds, withPadding: kPadding))
//    }
//   
//
//    let line = GMSPolyline(path: path)
//    line.strokeWidth = 4.0
//    line.strokeColor = UIColor.Application.darkThemeColor
//    line.isTappable = true
//    line.map = self
//    CATransaction.commit()
//  }
//    
//  func updateMap(toLocation location: CLLocation, zoomLevel: Float? = nil) {
//        if let zoomLevel = zoomLevel {
//            let cameraUpdate = GMSCameraUpdate.setTarget(location.coordinate, zoom: zoomLevel)
//            animate(with: cameraUpdate)
//        } else {
//            animate(toLocation: location.coordinate)
//        }
//  }
//    
//}
// 
//
//
