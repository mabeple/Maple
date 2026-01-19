//
//  UISwitchExtensions.swift
//  Maple
//
//  Created by cy on 2021/4/29.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods

@MainActor
public extension MapleWrapper where Base: UISwitch {
    /// Toggle a UISwitch.
    ///
    /// - Parameter animated: set true to animate the change (default is true).
    func toggle(animated: Bool = true) {
        base.setOn(!base.isOn, animated: animated)
    }
}
#endif
