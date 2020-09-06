//
//  CacheImageView.swift
//  App
//
//  Created by IOS Developer on 19/04/18.
//  Copyright © 2018 iOS Developer. All rights reserved.
//

import UIKit

class CacheImageView: UIImageView {
    
    static var sharedCache: NSCache<NSString, AnyObject> = {
       let cache = NSCache<NSString, AnyObject>()
       cache.name = "Cache"
       cache.countLimit = 50
       cache.totalCostLimit = 20 * 1024 * 1024 // 20 MB
       return cache
    }()
    
    let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
      indicator.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
      return indicator
    }()
    
    var urlString = String()
    
    func loadImage(urlString: String, completion: (()-> Void)? = nil) {
        
        if let image = CacheImageView.sharedCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = image
            completion?()
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        self.addSubview(indicator)
        indicator.center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        indicator.startAnimating()
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                  self.indicator.stopAnimating()
                  self.indicator.removeFromSuperview()
            }
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                CacheImageView.sharedCache.setObject(image
                    , forKey: urlString as NSString)
                DispatchQueue.main.async {
                    // Check before setting the image is the same the same url now as well
                    if urlString == self.urlString {
                       self.image = image
                    }
                    completion?()
                }
            }
        }.resume()
    }
    
    fileprivate func addIndicatorView() {
       addSubview(indicator)
       indicator.startAnimating()
    }
    
    fileprivate func removeIndicatorView() {
       indicator.stopAnimating()
       indicator.removeFromSuperview()
    }
    
}


