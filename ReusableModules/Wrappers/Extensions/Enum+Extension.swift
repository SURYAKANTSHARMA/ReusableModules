//
//  Enum+Extension.swift
//  YoGrowcerCustomer
//
//  Created by Mac mini on 6/18/18.
//  Copyright © 2018 SuryaKant Sharma. All rights reserved.
//

import Foundation

protocol CaseCountable {
    static var caseCount: Int { get }
}

extension CaseCountable where Self: RawRepresentable, Self.RawValue == Int {
    internal static var caseCount: Int {
        var count = 0
        while let _ = Self(rawValue: count) {
            count += 1
        }
        return count
    }
}


