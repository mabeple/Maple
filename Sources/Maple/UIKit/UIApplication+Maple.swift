//
//  UIApplication+Maple.swift
//  Maple-iOS
//
//  Created by cy on 2024/7/6.
//  Copyright © 2024 cy. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

extension UIApplication: MapleCompatible { }

// MARK: - Properties
@MainActor
public extension MapleWrapper where Base: UIApplication {
    
    /// Get the inner margin of the safe area of the device
    var safeAreaInsets: UIEdgeInsets {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        return windowScene.windows.first?.safeAreaInsets ?? .zero
    }
    
    /// Get the size of the device status bar (CGRect)
    var statusBarFrame: CGRect {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        return scene.statusBarManager?.statusBarFrame ?? .zero
    }
    
    /// Application running environment.
    ///
    /// - debug: Application is running in debug mode.
    /// - testFlight: Application is installed from Test Flight.
    /// - appStore: Application is installed from the App Store.
    enum Environment: CaseIterable {
        /// Application is running in debug mode.
        case debug
        /// Application is installed from Test Flight.
        case testFlight
        /// Application is installed from the App Store.
        case appStore
    }
    
    // Environment allCases
    var allEnvironments: [Environment] {
        Environment.allCases
    }
    
    /// Current inferred app environment.
    var environment: Environment {
        #if DEBUG
        return .debug

        #elseif targetEnvironment(simulator)
        return .debug

        #else
        if Bundle.main.path(forResource: "embedded", ofType: "mobileprovision") != nil {
            return .testFlight
        }

        guard let appStoreReceiptUrl = Bundle.main.appStoreReceiptURL else {
            return .debug
        }

        if appStoreReceiptUrl.lastPathComponent.lowercased() == "sandboxreceipt" {
            return .testFlight
        }

        if appStoreReceiptUrl.path.lowercased().contains("simulator") {
            return .debug
        }

        return .appStore
        #endif
    }
}
#endif
