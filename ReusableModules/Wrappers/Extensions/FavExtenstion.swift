//
//  FavExtenstion.swift
//  App
//
//  Created by Cl-macmini-100 on 12/13/17.
//  Copyright © 2017 Click-Labs. All rights reserved.
//

import UIKit
import CoreLocation


extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        switch self {
        case let string?:
            return string.isEmpty
        case nil:
            return true
        }
    }
}

extension URL {
    init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }
        
        self = url
    }
}


/**
 delay the line of codes.
 - Parameters:
 - seconds: no. of second block get delayed
 - completion: code block
 */

func delayWithSeconds(_ seconds: Double, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

extension UIViewController {
    func showAlert(title: String? = nil, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK".localized, style: .default) { _ in
            completion?()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(error: Error, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: error as? String ?? error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK".localized, style: .default) { _ in
            completion?()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
}

class TextField: UITextField {
    
    @IBInspectable var insetX: CGFloat = 0
    @IBInspectable var insetY: CGFloat = 0
    
    var defaultText: String? {
        get {
            return text
        }
        set {
            listener?(defaultText ?? "")
            text = defaultText
        }
    }
    
    typealias Listener = (String) -> Void
    var listener: Listener?
    
    func bindListener(listener: @escaping Listener) {
        self.listener = listener
        self.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textDidChange(_ textField: UITextField) {
        listener?(textField.text!)
    }
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
}


class DynamicCollectionView: UICollectionView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
            print("Could not dequeue cell with identifier: \(String(describing: T.self))")
            fatalError("Could not dequeue cell with identifier: \(String(describing: T.self))")
        }
        return cell
    }
}

public extension UINavigationController {
    public func push(viewController: UIViewController, animated: Bool = true) {
        self.pushViewController(viewController, animated: animated)
    }
    public func pop(animated: Bool = true) {
        popViewController(animated: true)
    }
}





protocol Shakeable {}

extension Shakeable where Self: UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

extension Date {
    enum TimeZone {
        case UTC
        case current
        
        func zone() -> Foundation.TimeZone {
            switch self {
            case .UTC:
                return Foundation.TimeZone(abbreviation: "UTC")!
            case .current:
                return Foundation.TimeZone.autoupdatingCurrent
            }
        }
    }
    
    enum DateFormat {
        case defaultServerFormat
        case other(format: String)
        
        func format() -> String {
            switch self {
            case .defaultServerFormat:
                return "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            case .other(let format):
                return format
            }
        }
    }
    
    func string(_ timeZone: TimeZone, dateStyle: DateFormatter.Style? = nil, timeStyle: DateFormatter.Style? = nil) -> String {
        let formatter = DateFormatter()
        if let dateStyle = dateStyle {
            formatter.dateStyle = dateStyle
        }
        if let timeStyle = timeStyle {
            formatter.timeStyle = timeStyle
        }
        formatter.timeZone = timeZone.zone()
        return formatter.string(from: self)
    }
    
    func string(_ dateFormat: String, timeZone: TimeZone) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = timeZone.zone()
        return formatter.string(from: self)
    }
}

extension String {
    func convert(toFormat: String,
                 fromFormat: String = Date.DateFormat.defaultServerFormat.format(),
                 fromTimeZone: Date.TimeZone = Date.TimeZone.UTC) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = fromTimeZone.zone()
        formatter.dateFormat = fromFormat
        if let date = formatter.date(from: self) {
            formatter.timeZone = Date.TimeZone.current.zone()
            formatter.dateFormat = toFormat
            return formatter.string(from: date)
        }
        fatalError("cann't convert date from string: \(self)")
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    mutating func addMinorDifference() {
        self.latitude = latitude.advanced(by: Double.leastNormalMagnitude)
        self.longitude = longitude.advanced(by: Double.leastNormalMagnitude)
    }
}

public extension Float {
    
    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    public static var random: Float {
        // 0xFFFFFFFF - (2^32 - 1)
        return Float(arc4random()) / 0xFFFFFFFF
    }
    
    /// Random float between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random float point number between 0 and n max
    public static func random(min: Float, max: Float) -> Float {
        return Float.random * (max - min) + min
    }
}



extension UIImageView {
    @IBInspectable var rounded: Bool {
        set {
            if newValue {
                layer.cornerRadius = frame.height/2
                layer.masksToBounds = true
                layer.borderWidth = 2
                layer.borderColor = UIColor.white.cgColor
            } else {
                layer.cornerRadius = 0
            }
        }
        get {
            return self.rounded
        }
    }
}

extension UIImage {
    func resize(scaledToSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}




