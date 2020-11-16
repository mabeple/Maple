//
//  UIAlertAction+Maple.swift
//  Maple
//
//  Created by cy on 2020/11/16.
//  Copyright © 2020 cy. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit
extension UIAlertAction: MabpleCompatible { }

// MARK: - Properties
public extension MabpleWrapper where Base == UIAlertAction {
    
    /// TitleTextColor
    var titleTextColor: UIColor? {
        get { base.value(forKey: "titleTextColor") as? UIColor }
        set { base.setValue(newValue, forKey: "titleTextColor") }
    }
}
#endif
