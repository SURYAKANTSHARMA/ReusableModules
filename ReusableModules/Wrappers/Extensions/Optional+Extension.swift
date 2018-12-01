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
