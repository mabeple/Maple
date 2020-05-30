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
public extension MabpleWrapper where Base: Bundle {
    
    /// Application name (if applicable).
    var displayName: String? {
        #if os(iOS)
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
        #elseif os(macOS)
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
        #endif
    }
    
    /// App current build identifier (if applicable).
    var bundleIdentifier: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleIdentifierKey as String) as? String
    }
    
    /// App current build number (if applicable).
    var build: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    
    /// App's current version number (if applicable).
    var version: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
#endif
