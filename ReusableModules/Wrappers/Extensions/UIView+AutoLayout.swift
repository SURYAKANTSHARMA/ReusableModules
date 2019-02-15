//
//  UIView+AutoLayout.swift
//  ReusableModules
//
//  Created by Mac mini on 11/15/18.
//  Copyright © 2018 Mac mini. All rights reserved.
//

import UIKit


extension UIView {

    func addSubViewUsingAutoLayout(views: UIView...) {
        views.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }

}


@objc extension NSLayoutAnchor {
    
    @discardableResult
    func constrain(_ relation: NSLayoutConstraint.Relation = .equal,
                   to anchor: NSLayoutAnchor,
                   with constant: CGFloat = 0.0,
                   prioritizeAs priority: UILayoutPriority = .required,
                   isActive: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        
        switch relation {
        case .equal:
            constraint = self.constraint(equalTo: anchor, constant: constant)
            
        case .greaterThanOrEqual:
            constraint = self.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            
        case .lessThanOrEqual:
            constraint = self.constraint(lessThanOrEqualTo: anchor, constant: constant)
        }
        
        constraint.set(priority: priority, isActive: isActive)
        return constraint
    }
}


extension NSLayoutConstraint {
    func set(priority: UILayoutPriority, isActive: Bool) {
        self.priority = priority
        self.isActive = isActive
    }
}

extension NSLayoutDimension {
    
    @discardableResult
    func constrain(_ relation: NSLayoutConstraint.Relation = .equal,
                   to anchor: NSLayoutDimension,
        with constant: CGFloat = 0.0,
        multiplyBy multiplier: CGFloat = 1.0,
        prioritizeAs priority: UILayoutPriority = .required,
        isActive: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        
        switch relation {
        case .equal:
            constraint = self.constraint(equalTo: anchor, multiplier: multiplier, constant: constant)
            
        case .greaterThanOrEqual:
            constraint = self.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
            
        case .lessThanOrEqual:
            constraint = self.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
        }
        
        constraint.priority = priority
        constraint.isActive = isActive
        
        return constraint
    }
    
    @discardableResult
    func constrain(_ relation: NSLayoutConstraint.Relation = .equal,
                   to constant: CGFloat = 0.0,
                   prioritizeAs priority: UILayoutPriority = .required,
                   isActive: Bool = true) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        
        switch relation {
        case .equal:
            constraint = self.constraint(equalToConstant: constant)
            
        case .greaterThanOrEqual:
            constraint = self.constraint(greaterThanOrEqualToConstant: constant)
            
        case .lessThanOrEqual:
            constraint = self.constraint(lessThanOrEqualToConstant: constant)
        }
        
        constraint.priority = priority
        constraint.isActive = isActive
        
        return constraint
    }
    
    
    
}

func test () {
    let a = UIView()
    let b = UIView()
    
    
    a.addSubViewUsingAutoLayout(views: b)
    b.bottomAnchor.constrain(.greaterThanOrEqual, to: a.bottomAnchor)
    let bWidth = b.widthAnchor.constrain(to: 50.0)
    bWidth.priority = .defaultHigh + 50
}


extension UILayoutPriority {
    static func +(lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
        return UILayoutPriority(rawValue: lhs.rawValue + rhs)
    }
    
    static func -(lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
        return UILayoutPriority(rawValue: lhs.rawValue + rhs)
    }
}

