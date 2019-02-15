//
//  CGSize+Extension.swift
//  ReusableModules
//
//  Created by Mac mini on 2/15/19.
//  Copyright © 2019 Mac mini. All rights reserved.
//

import UIKit

extension CGSize {
    static func +(lhs: CGSize, rhs: CGSize) -> CGPoint {
        return CGPoint(
            x: lhs.width + rhs.width,
            y: lhs.height + rhs.height
        )
    }
    static func +(lhs: CGSize, rhs: (x: CGFloat, y: CGFloat)) -> CGPoint {
        return CGPoint(
            x: lhs.width + rhs.x,
            y: lhs.height + rhs.y
        )
    }
}

infix operator ~>

func ~><T>(expression: @autoclosure () throws -> T,
           errorTransform: (Error) -> Error) throws -> T {
    do {
        return try expression()
    } catch {
        throw errorTransform(error)
    }
}
