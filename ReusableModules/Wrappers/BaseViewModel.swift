//
//  BaseViewModel.swift
//  YoGrowcerCustomer
//
//  Created by IOS Developer on 25/04/18.
//  Copyright © 2018 iOS Developer. All rights reserved.
//

import Foundation

class Dynamic<T> {
    
    // MARK: Properties
    typealias Listener = (T) -> Void
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    // MARK: - Function
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
    func bindAndFire(listener: Listener?) {
        self.listener = listener
        self.listener?(value)
    }
    
}

struct BrokenRule {
    
    var propertyName :String
    var message :String
}

protocol ValidatableViewModel {
    
    var brokenRules :[BrokenRule] { get set}
    var isValid :Bool { mutating get }
}
