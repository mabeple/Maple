//
//  BoolExtensions.swift
//  Maple
//
//  Created by cy on 2026/1/8.
//  Copyright © 2026 cy. All rights reserved.
//

import Foundation

extension Bool: MapleCompatibleValue {}

public extension MapleWrapper where Base == Bool {
    /// Return 1 if true, or 0 if false.
    ///
    ///        false.int -> 0
    ///        true.int -> 1
    ///
    var int: Int {
        return base ? 1 : 0
    }

    /// Return "true" if true, or "false" if false.
    ///
    ///        false.string -> "false"
    ///        true.string -> "true"
    ///
    var string: String {
        return base ? "true" : "false"
    }
}
