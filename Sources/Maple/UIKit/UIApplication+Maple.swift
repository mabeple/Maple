//
//  UIApplication+Maple.swift
//  Maple-iOS
//
//  Created by cy on 2024/7/6.
//  Copyright © 2024 cy. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Properties
public extension MabpleWrapper where Base: UIApplication {
    var safeAreaInsets: UIEdgeInsets {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        return windowScene.windows.first?.safeAreaInsets ?? .zero
    }
}
#endif
