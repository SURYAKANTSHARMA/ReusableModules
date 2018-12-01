//
//  Extension.swift
//  App
//
//  Created by Suryakant Sharma on 12/4/16.
//  Copyright © 2016 Suryakant Sharma. All rights reserved.
//


import UIKit

// MARK:- 
extension UIImage {
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in PNG format
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    ///
    /// Returns a data object containing the PNG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    var pngData: Data? { return self.pngData() }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpegData(_ quality: JPEGQuality) -> Data? {
        return self.jpegData(compressionQuality: quality.rawValue)
    }
    
    func reduce(maxSize: Int = 250) -> Data? {
        
        let currentImage = self;
        var compression: Float = 0.9
        let maxCompression: Float = 0.1
        let maxFileSize: Int = maxSize * 1024
        
        var imageData: Data? = self.jpegData(compressionQuality: 0.99)
        if (imageData == nil){
            return nil
        }
        
        while ( (imageData!.count > maxFileSize) && (compression > maxCompression)) {
            compression -= 0.1
            imageData =  currentImage.jpegData(compressionQuality: CGFloat(compression))
        }
        return imageData
    }

    func fixOrientation() -> UIImage {
        UIGraphicsBeginImageContext(size)
        draw(at: .zero)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
    
}

