//
//  UISwitch+Maple.swift
//  Maple-iOS
//
//  Created by cy on 2021/4/29.
//  Copyright © 2021 cy. All rights reserved.
//

#if canImport(UIKit) && os(iOS)
import UIKit

// MARK: - Methods
public extension MabpleWrapper where Base: UISwitch {
    /// Toggle a UISwitch.
    ///
    /// - Parameter animated: set true to animate the change (default is true).
    func toggle(animated: Bool = true) {
        base.setOn(!base.isOn, animated: animated)
    }
}
#endif
