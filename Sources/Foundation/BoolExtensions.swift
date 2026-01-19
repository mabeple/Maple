//
//  BoolExtensions.swift
//  Maple
//
//  Created by cy on 2026/1/8.
//

import Foundation

extension Bool: MapleCompatibleValue {}

public extension MapleWrapper where Base == Bool {
    /// Return 1 if true, or 0 if false.
    ///
    ///        false.mp.int -> 0
    ///        true.mp.int -> 1
    ///
    var int: Int {
        return base ? 1 : 0
    }

    /// Return "true" if true, or "false" if false.
    ///
    ///        false.mp.string -> "false"
    ///        true.mp.string -> "true"
    ///
    var string: String {
        return base ? "true" : "false"
    }
}
