//
//  BlackContainerView.swift
//  Personal
//
//  Created by Suryakant Sharma on 5/26/17.
//  Copyright © 2017 Suryakant Sharma. All rights reserved.
//

import UIKit

class BlackContainerView: UIView, UIGestureRecognizerDelegate {
    
    public var blackAlpha: CGFloat = 0.5 {
        didSet {
            setNeedsLayout()
        }
    }
    override var frame: CGRect {
        didSet {
            addGesture()
        }
    }
    var onTapDismiss: (() -> Void)? = nil
    
    func addGesture() {
        DispatchQueue.main.async {
            self.backgroundColor = UIColor.black.withAlphaComponent(self.blackAlpha)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(_:)))
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(tapGesture)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        addGesture()
    }
    
    convenience init(frame: CGRect, onTapDismiss: @escaping () -> Void) {
        self.init(frame: frame)
        addGesture()
        self.onTapDismiss = onTapDismiss
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func viewTapped(_ sender: Any) {
         _ = self.subviews.forEach  {    $0.removeFromSuperview() }
        removeFromSuperview()
        onTapDismiss?()
    }
}


