//
//  SwiftyButton.swift
//  Rider
//
//  Created by Mac mini on 8/27/18.
//  Copyright © 2018 Mac mini. All rights reserved.
//

import UIKit

class SwiftyButton: UIButton {
    
    var action: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    private func sharedInit() {
        addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
    }

    @objc func touchUpInside() {
        action?()
    }

}



