//
//  UIView+Extension.swift
//  App
//
//  Created by Suryakant Sharma on 12/4/16.
//  Copyright © 2016 Suryakant Sharma. All rights reserved.
//


import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return self.borderColor
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var backgroundImage: UIImage? {
        get {
            return self.backgroundImage
        }
        set {
            let imageView = UIImageView()
            imageView.frame = self.frame
            imageView.image = newValue
            self.addSubview(imageView)
            self.sendSubviewToBack(imageView)
        }
    }
    
    static func loadNib(nibName:String!) -> UIView? {
        let loadedViews:[UIView]? = Bundle.main.loadNibNamed(nibName, owner: self, options: nil) as? [UIView];
        if loadedViews != nil {
            return loadedViews?.first
        }else {
            return nil
        }
    }
    
    func loadNib() -> UIView? {
        return UIView.loadNib(nibName: String(describing: UIView.self))
    }
    
    static func loadNib<T>() -> T? {
        let loadedViews:[UIView]? = Bundle.main.loadNibNamed(String(describing: T.self), owner: self, options: nil) as? [UIView]
        if loadedViews != nil {
            return loadedViews?.first as? T
        }
        return nil
    }
    
    func addborder(width: CGFloat, color: UIColor, radius: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = radius
    }
    
    func addShadowView() {
        //self.layer.shadowOffset =  CGSize(width: 1.0, height: 1.0)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
    }
    
    func addShadowAndBorder() {
        //self.layer.shadowOffset =  CGSize(width: 1.0, height: 1.0)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.gray.cgColor
    }
    
    func showToast(message: String, view: UIView = UIApplication.shared.keyWindow!.rootViewController!.view) {
        let windowRootView: UIView = view 
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
    
    func resizeXib(newHeight: CGFloat){
        var testRect: CGRect = frame
        testRect.size.height = newHeight
        frame = testRect
    }

}

extension CGFloat {
    static var zero: CGFloat  = CGFloat(0)
}











