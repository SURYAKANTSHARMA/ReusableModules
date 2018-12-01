//
//  UIAlertController+Extension.swift
//  App
//
//  Created by Suryakant Sharma on 12/4/16.
//  Copyright © 2016 Suryakant Sharma. All rights reserved.
//


import UIKit

// MARK:- Alert Extension
extension UIAlertController {
    
    func present() {
       guard let rootViewController = appDelegate.topViewController() else {
        print("NO ROOT VIEW CONTROLLER")
        return
      }
        if let alertController = rootViewController as? UIAlertController {
            alertController.dismiss(animated: true, completion: nil)
        }
        delayWithSeconds(0.1) {
             rootViewController.present(self, animated: true, completion: nil)
        }
    }
    
    @discardableResult
    func action(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let action: UIAlertAction = UIAlertAction(title: title, style: style, handler: handler)
        self.addAction(action);
        return self;
    }
    
    @discardableResult
    class func alert(title: String?, message: String?, style: UIAlertController.Style) -> UIAlertController {
        let alertController: UIAlertController  = UIAlertController(title: title, message: message, preferredStyle: style)
        return alertController
    }
    
    class func presentAlert(title: String?, message: String?, style: UIAlertController.Style) -> UIAlertController {
        let alertController = UIAlertController.alert(title: title, message: message, style: style);
        alertController.present()
        return alertController
    }
    
    class func showAlertWithError(_ error: Error) {
        UIAlertController.presentAlert(title: nil, message: error as? String ?? error.localizedDescription, style: .alert).action(title: "OK".localized, style: .default, handler: { (alert: UIAlertAction) in
        })
    }
    
    class func showConfirmationAlert(title: String?, message: String?, callBack: (() -> Void)? = nil ) {
        UIAlertController.presentAlert(title: title, message: message, style: .alert).action(title: "OK".localized, style: .default)  { action in
            callBack?()
            }.action(title: "No", style: .cancel, handler: nil)
    }
    

    class func showAlert(title: String?, message: String?, callBack: (() -> Void)? = nil ) {
       UIAlertController.presentAlert(title: title, message: message, style: .alert).action(title: "OK".localized, style: .default)  { action in
            callBack?()
        }
    }
    
    class func retryAlert(title: String?, message: String?, retryCallBack: (() -> Void)? = nil, cancelCallBack: (() -> Void)? = nil) {
        UIAlertController.presentAlert(title: title, message: message, style: .alert).action(title: "Retry".localized, style: .default)  { action in
            retryCallBack?()
            }.action(title: "Cancel".localized, style: .default) { action in
            ProgressView.shared.stopAnimatimating()
            cancelCallBack?()
        }
    }
    
}

// MARK:- ActionSheet Extension

protocol NameRepresentable {
    var name: String { get }
}
typealias ActionTapped = (_ option: NameRepresentable?) -> Void

extension UIAlertController {
    
    @discardableResult
    class func presentActionSheet(title: String, options: [NameRepresentable], callBack: @escaping ActionTapped) -> UIAlertController {
        let actionSheet = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        actionSheet.configure(title: title)
        for option in options {
            let action = UIAlertAction(title: option.name, style: .default) { (action) in
                callBack(option)
            }
            actionSheet.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            callBack(nil)
        }
        actionSheet.addAction(cancelAction)
        actionSheet.present()
        return actionSheet
    }
    
    
    fileprivate func configure(title: String) {
        let titleFont = [NSAttributedString.Key.font: UIFont.Application.fontBold(size: 18)]
        let titleAttrString = NSMutableAttributedString(string: title, attributes: titleFont)
        self.setValue(titleAttrString, forKey: "attributedTitle")
        //let messageFont = [NSAttributedString.Key.font: UIFont.Growser.font(size: 12)]
        //let messageAttrString = NSMutableAttributedString(string: "Message Here", attributes: messageFont)
        //self.setValue(messageAttrString, forKey: "attributedMessage")
    }
    
}

// MARK: - UIAlertAction
extension UIAlertAction {
    var image: UIImage? {
        get {
            return self.value(forKey: "image") as? UIImage
        }
        set(image) {
            self.setValue(image, forKey: "image")
        }
    }
}




