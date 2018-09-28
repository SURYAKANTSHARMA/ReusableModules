//
//  Growser+Helper.swift
//  YoGrowcerCustomer
//
//  Created by IOS Developer on 07/05/18.
//  Copyright © 2018 SuryaKant Sharma. All rights reserved.
//

import UIKit


extension UIColor {
    struct Application {
        static let lightThemeColor = UIColor(red: 255/255, green: 244/255, blue: 0, alpha: 1)
        static let darkThemeColor = UIColor.black
        static let grayThemeColor = UIColor.gray
    }
}

extension UINavigationController {
    func setUpDefaultNavigationConfig() {
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.Application.darkThemeColor]
        navigationBar.barTintColor = UIColor.Application.lightThemeColor
        navigationBar.tintColor = UIColor.Application.darkThemeColor
    }
}

extension UIFont {
    struct Application {
        static func font(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size)
        }
        static func fontSemiBold(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.semibold)
        }
        static func fontBold(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.bold)
        }
    }
}

func showToast(message: String) {
    guard let windowRootView = appDelegate.topViewController()?.view else {
        return
    }
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
    
    //animate on removal
    UIView.animate(withDuration: 4, delay: 0.1, options: .curveEaseOut, animations: {
        messageLabel.alpha = 0.0
    }) { completion in
        messageLabel.removeFromSuperview()
    }
}


extension UIAlertController {
    class func showAlertForLoginRequest(title: String? = nil, message: String? = "Please login first.".localized , callBack: (() -> Void)? = nil ) {
        UIAlertController.presentAlert(title: title, message: message, style: .alert).action(title: "OK", style: .default)  { action in
            if let callBack = callBack {
                callBack()
             } else {
              // sendUserToOnBoarding()
            }
       }.action(title: "Cancel", style: .cancel, handler: nil)
    }
}






extension UIButton {
    // background and border & radius
    func applyDefaultConfigurationForApp() {
        backgroundColor = UIColor.Application.lightThemeColor
        cornerRadius = 15
        clipsToBounds = true
        borderColor = UIColor.Application.darkThemeColor
        borderWidth = 1
        setTitleColor(UIColor.black, for: .normal)
    }
}


extension UIStoryboard {
     enum _Type {
        case main
        case homeTab
        case sideMenu
        case myOrder
    }
    
    static let main = UIStoryboard(name: "Main", bundle: Bundle.main)
    static let home = UIStoryboard(name: "HomeTab", bundle: Bundle.main)
    static let sideMenu = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
    static let myOrder = UIStoryboard(name: "MyOrder", bundle: Bundle.main)
    
    
}

extension UIStoryboard {
    func instantiateViewController<T>() -> T {
        if let viewController = self.instantiateViewController(withIdentifier: String(describing: T.self)) as? T {
            return viewController
        }
        fatalError("Cann't instantiate view controller of type \(T.self)")
    }
    
    static func instantiateViewController<T>(type: UIStoryboard._Type) -> T {
        switch type {
        case .main:
            if let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: String(describing: T.self)) as? T {
              return viewController
            }
            fatalError("Cann't instantiate view controller of type \(T.self)")
        case .homeTab:
            if let viewController = UIStoryboard.home.instantiateViewController(withIdentifier: String(describing: T.self)) as? T {
                return viewController
            }
            fatalError("Cann't instantiate view controller of type \(T.self)")
        case .sideMenu:
            if let viewController = UIStoryboard.sideMenu.instantiateViewController(withIdentifier: String(describing: T.self)) as? T {
                return viewController
            }
            fatalError("Cann't instantiate view controller of type \(T.self)")
        case .myOrder:
            if let viewController = UIStoryboard.myOrder.instantiateViewController(withIdentifier: String(describing: T.self)) as? T {
                return viewController
            }
            fatalError("Cann't instantiate view controller of type \(T.self)")
        }
    }
}


extension URL {
    static let privacyPolicy = URL(string: "http://direnzictechnology.yogrowcer.com/index.php?route=information/information-app&information_id=3")!
    static let checkOut = URL(string: "http://direnzictechnology.yogrowcer.com/en/checkout/checkout.html")!
}


extension UIWindow {
//    static func pushLoginVC() {
//        let loginVC: LoginViewController = UIStoryboard.instantiateViewController(type: .main)
//        if let topMostNavigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
//            topMostNavigationController.push(viewController: loginVC)
//        }
//    }
}

extension UIStoryboardSegue {
    public static let applyCoupon = "applyCoupon"
    public static let estimatePriceTax = "estimatePriceTax"
}

extension NSNotification.Name {
    public static let cartChanged = NSNotification.Name(rawValue: "CartChanged")
    public static let growcerItemChange = NSNotification.Name(rawValue: "growcerItemChange")
    public static let profileUpdated = NSNotification.Name(rawValue: "profileUpdated")
}

class ApplicationConstant {
    static let deviceToken = "InSimulator"
    static let type = "DRIVER"
}
