//
//  UIApplicationExtensions.swift
//  Maple
//
//  Created by cy on 2024/7/6.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

extension UIApplication: MapleCompatible { }

// MARK: - Properties

@MainActor
public extension MapleWrapper where Base: UIApplication {
    
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
    var inferredEnvironment: Environment {
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
