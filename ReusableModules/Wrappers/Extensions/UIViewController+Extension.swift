//
//  UIViewController+Extension.swift
//  YoGrowcerCustomer
//
//  Created by IOS Developer on 15/05/18.
//  Copyright © 2018 SuryaKant Sharma. All rights reserved.
//

import UIKit
import CoreLocation

extension UIViewController {
    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */
    
    var topbarHeight: CGFloat {
        if let navigationBarHidden = navigationController?.navigationBar.isHidden, !navigationBarHidden {
            return UIApplication.shared.statusBarFrame.size.height +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        }
        return UIApplication.shared.statusBarFrame.size.height
    }
    
    func showToast(message: String) {
        let windowRootView: UIView = appDelegate.topViewController()?.view ?? self.view
        let messageLabel = UILabel(frame: CGRect(x: 0, y: windowRootView.frame.size.height - 100, width: 300, height: 35))
        messageLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        messageLabel.textColor = UIColor.white
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 12)
        messageLabel.text = message
        messageLabel.center.x = windowRootView.center.x
        messageLabel.alpha = 1.0
        messageLabel.layer.cornerRadius = 10
        messageLabel.clipsToBounds = true
        windowRootView.addSubview(messageLabel)
        //addConstraint(toastLabel: messageLabel, windowRootView: windowRootView)
        
        //animate on removal
        UIView.animate(withDuration: 4, delay: 0.1, options: .curveEaseOut, animations: {
            messageLabel.alpha = 0.0
        }) { completion in
            messageLabel.removeFromSuperview()
        }
    }
    
    func showToastAtCenter(message: String) {
        let windowRootView: UIView = appDelegate.topViewController()?.view ?? self.view
        let messageLabel = UILabel(frame: CGRect(x: 0, y: windowRootView.frame.size.height/2, width: 300, height: 35))
        messageLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        messageLabel.textColor = UIColor.white
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 12)
        messageLabel.text = message
        messageLabel.center.x = windowRootView.center.x
        messageLabel.alpha = 1.0
        messageLabel.layer.cornerRadius = 10
        messageLabel.clipsToBounds = true
        windowRootView.addSubview(messageLabel)
        //addConstraint(toastLabel: messageLabel, windowRootView: windowRootView)
        
        //animate on removal
        UIView.animate(withDuration: 4, delay: 0.1, options: .curveEaseOut, animations: {
            messageLabel.alpha = 0.0
        }) { completion in
            messageLabel.removeFromSuperview()
        }
    }
    
    func addConstraint(toastLabel: UILabel, windowRootView: UIView) {
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastLabel.centerXAnchor.constraint(equalTo: windowRootView.centerXAnchor)
        toastLabel.numberOfLines = 0
        toastLabel.leftAnchor.constraint(equalTo: windowRootView.leftAnchor, constant: 20).isActive = true
        toastLabel.rightAnchor.constraint(equalTo: windowRootView.rightAnchor, constant: 20).isActive = true
        if #available(iOS 11.0, *) {
            toastLabel.bottomAnchor.constraint(equalTo: windowRootView.safeAreaLayoutGuide.bottomAnchor, constant: 20).isActive = true
        } else {
            // Fallback on earlier versions
            toastLabel.bottomAnchor.constraint(equalTo: windowRootView.bottomAnchor, constant: 20).isActive = true
        }
    }
    
    var isVisible: Bool {
        if isViewLoaded {
            return view.window != nil
        }
        return false
    }
    
    var isTopViewController: Bool {
        if self.navigationController != nil {
            return self.navigationController?.visibleViewController === self
        } else if self.tabBarController != nil {
            return self.tabBarController?.selectedViewController == self && self.presentedViewController == nil
        } else {
            return self.presentedViewController == nil && self.isVisible
        }
    }
    
     func makeCallDiallerApp(phoneNumber: String) {
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func navigateToGoogleMap(place: CLLocationCoordinate2D) {
        print("comgooglemaps://?saddr=&daddr=\(place.latitude),\(place.longitude)&directionsmode=driving")
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.open(URL(string:
                "comgooglemaps://?saddr=&daddr=\(place.latitude),\(place.longitude)&directionsmode=driving")!)
        } else {
            NSLog("Can't use comgooglemaps://");
        }
    }
    
    
}



