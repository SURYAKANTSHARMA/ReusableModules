//
//  RangeSliderTrackerLayer.swift
//  RangeSlider
//
//  Created by IOS Developer on 09/05/18.
//  Copyright © 2018 iOS Developer. All rights reserved.
//

import UIKit

class RangeSliderTrackerLayer: CALayer {
    
    weak var rangeSlider: RangeSlider?
    
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        if let slider = rangeSlider {
            // Clip
            let cornerRadius = bounds.height * slider.curvaceousness / 2.0
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            ctx.addPath(path.cgPath)
            
            // Fill the track
            ctx.setFillColor(slider.trackTintColor.cgColor)
            ctx.addPath(path.cgPath)
            ctx.fillPath()
            
            // Fill the highlighted range
            ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
            let lowerValuePosition = CGFloat(slider.positionForValue(slider.lowerValue))
            let upperValuePosition = CGFloat(slider.positionForValue(slider.upperValue))
            let rect = CGRect(x: lowerValuePosition, y: 0.0, width: upperValuePosition - lowerValuePosition, height: bounds.height)
            ctx.fill(rect)
        }
    }
}
