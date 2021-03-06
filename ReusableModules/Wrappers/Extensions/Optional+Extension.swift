//
//  Optional + Extension.swift
//  ReusableModules
//
//  Created by Mac mini on 12/1/18.
//  Copyright © 2018 Mac mini. All rights reserved.
//

import Foundation

var isDebug: Bool {
    #if DEBUG
    return true
    #else
    return false
    #endif
}

func assert(_ expression: @autoclosure () -> Bool,
            _ message: @autoclosure () -> String) {
    
    guard isDebug else {
        return
    }
    
    // Inside assert we can refer to expression as a normal closure
    if !expression() {
        assertionFailure(message())
    }
    
}


extension Optional {
    
    func orThrow(_ errorExpression: @autoclosure () -> Error) throws -> Wrapped {
        guard let value = self else {
            throw errorExpression()
        }
        return value
    }
    
    func matching(_ predicate: (Wrapped) -> Bool) -> Wrapped? {
        guard let value = self else {
            return nil
        }
        
        guard predicate(value) else {
            return nil
        }
        
        return value
    }
    
}


extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}

extension Dictionary where Value == Any {
    func value<T>(forKey key: Key, defaultValue: @autoclosure () -> T) -> T {
        guard let value = self[key] as? T else {
            return defaultValue()
        }
        
        return value
    }
}




infix operator ???: NilCoalescingPrecedence
public func ???<T> (optional: T?,
                    defaultValue:  @autoclosure () -> String) -> String {
    switch optional {
    case .some(let value):
        return String(describing: value)
    case .none:
        return defaultValue()
    }
}

/**
 Function for equating two optionals
 e.g
 if textField.text == "Placeholder Text"
 */

func == <T>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs)  {
    case let (x?, y?):
        return x == y
    case (nil, nil):
        return true
    default:
        return false
    }
}
