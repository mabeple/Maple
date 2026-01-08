//
//  SignedNumericExtensions.swift
//  Maple
//
//  Created by cy on 2026/1/8.
//  Copyright © 2026 cy. All rights reserved.
//

// MARK: - Properties

public extension MapleWrapper where Base: SignedNumeric {
    /// String.
    var string: String {
        return String(describing: base)
    }
}
