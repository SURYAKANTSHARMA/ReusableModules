//
//  App+Extension.swift
//  App
//
//  Created by Suryakant Sharma on 12/4/16.
//  Copyright © 2016 Suryakant Sharma. All rights reserved.
//

import UIKit

// MARK :- - Application  Extensions
var application: UIApplication {
    return UIApplication.shared
}
var appDelegate: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}
var rootViewController: UIViewController? {
    return application.keyWindow?.rootViewController
}


// MARK:- Extension UIWindow
public extension UIWindow {
    
    public var visibleViewController: UIViewController? {
        get {
            return UIWindow.getVisibleViewControllerFrom(vc: self.rootViewController)
        }
    }
    
    private static func getVisibleViewControllerFrom(vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(vc: nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(vc: tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(vc: pvc)
            } else {
                return vc
            }
        }
    }
    
}

extension AppDelegate {
    
    // MARK :- - 
    func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topViewController(top)
            } else if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        
        return base
    }
    
    public func changeRootViewController(_ rootViewController: UIViewController, animated: Bool = true, from: UIViewController? = nil, completion: ((Bool) -> Void)? = nil) {
        let window = UIApplication.shared.keyWindow
        if let window = window, animated {
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                let oldState: Bool = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                window.rootViewController = rootViewController
                window.makeKeyAndVisible()
                UIView.setAnimationsEnabled(oldState)
            }, completion: completion)
        } else {
            window?.rootViewController = rootViewController
        }
    }
    
    
    
    /**
     Change rootViewController of main window after dismissing current controller ( if current controller was presented). This avoids keeping unused view controllers in hidden windows
     
     - parameter from:       UIViewController from which to start the switch
     - parameter to:         UIViewController to be set as new rootViewController
     - parameter completion: Handler to be executed when controller switch finishes
     */
    public func changeRootViewControllerAfterDismiss(_ from: UIViewController? = nil, to: UIViewController, completion: ((Bool) -> Void)? = nil) {
        if let presenting = from?.presentingViewController {
            presenting.view.alpha = 0
            from?.dismiss(animated: false, completion: {
                self.changeRootViewController(to, completion: completion)
            })
        } else {
            changeRootViewController(to, completion: completion)
        }
    }
    
    
    // MARK:-  Private
    private func infoDict() -> [String : Any]? {
        if let info = Bundle.main.infoDictionary {
            return info
        }else {
            return nil;
        }
    }
    
    // MARK:-  App Setting Info
    var baseURL: String {
        if let name = Bundle.main.infoDictionary?["serverUrl"] as? String {
            return name;
        }
        return "Unknown"
    }
    
    var key: String {
        if let name = Bundle.main.infoDictionary?["key"] as? String {
            return name;
        }
        return "Unknown"
    }
    
    var facebookId: String {
        if let name = Bundle.main.infoDictionary?["kFacebookID"] as? String {
            return name;
        }
        return "Unknown"
    }
    
    
    // MARK:-  Project Info
    var displayName: String {
        if let name = Bundle.main.infoDictionary?["CFBundleName"] as? String {
            return name;
        }
        if let name = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String {
            return name
        }
        return "Unknown"
    }
    
    var googleAPIKey: String {
        if let name = Bundle.main.infoDictionary?["googleApiKey"] as? String {
            return name;
        }
        return "Unknown"
    }
    
    var appVersion: String {
        get {
            if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                return version
            }
            if let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                return version
            }
            return "Unknown"
        }
    }
    
    
    var bundle: String {
        if let info = self.infoDict() {
            return info[kCFBundleIdentifierKey as String] as? String ?? "Unknown"
        }
        return "Unknown"
    }
    
    var executable: String {
        if let info = self.infoDict() {
            return info[kCFBundleExecutableKey as String] as? String ?? "Unknown"
        }
        return "Unknown"
    }
    
    var build: String {
        if let info = self.infoDict() {
            return info[kCFBundleVersionKey as String] as? String ?? "Unknown"
        }
        return "Unknown"
    }
    
    var osName: String {
        #if os(iOS)
        return "iOS"
        #elseif os(watchOS)
        return "watchOS"
        #elseif os(tvOS)
        return "tvOS"
        #elseif os(macOS)
        return "OS X"
        #elseif os(Linux)
        return "Linux"
        #else
        return "Unknown"
        #endif
    }
    
    var osVersion: String {
        let version = ProcessInfo.processInfo.operatingSystemVersion
        let versionString = "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
        return versionString;
    }
    
}




