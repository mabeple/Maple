//
//  NSApplication.swift
//  Maple
//
//  Created by cy on 2020/5/10.
//  Copyright © 2020 cy. All rights reserved.
//

#if canImport(Foundation)
import Foundation
extension Bundle: MabpleCompatible { }

// MARK: - Properties
public extension MabpleWrapper where Base: Bundle {
    
    /// Application name (if applicable).
    var displayName: String? {
        #if os(iOS)
        return info(for: "CFBundleDisplayName") ?? info(for: "CFBundleName")
        #elseif os(macOS)
        return info(for: "CFBundleName")
        #endif
    }
    
    /// App current build identifier (if applicable).
    var bundleIdentifier: String? {
        info(for: kCFBundleIdentifierKey as String)
    }
    
    /// App current build number (if applicable).
    var build: String? {
        info(for: kCFBundleVersionKey as String)
    }
    
    /// App's current version number (if applicable).
    var version: String? {
        info(for: "CFBundleShortVersionString")
    }
    
}

// MARK: - Methods
public extension MabpleWrapper where Base: Bundle {
    
    private func info<T>(for key: String) -> T? {
        (base.localizedInfoDictionary?[key] as? T)
            ?? (base.infoDictionary?[key] as? T)
    }
}
#endif
