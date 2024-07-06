//
//  Runtime.swift
//  Maple-iOS
//
//  Created by cy on 2024/5/7.
//  Copyright © 2024 cy. All rights reserved.
//

import Foundation

public func getAssociatedObject<T>(_ object: Any, _ key: UnsafeRawPointer) -> T? {
    if #available(iOS 14, macOS 11, watchOS 7, tvOS 14, *) { // swift 5.3 fixed this issue (https://github.com/apple/swift/issues/46456)
        return objc_getAssociatedObject(object, key) as? T
    } else {
        return objc_getAssociatedObject(object, key) as AnyObject as? T
    }
}

public func setRetainedAssociatedObject<T>(_ object: Any, _ key: UnsafeRawPointer, _ value: T) {
    objc_setAssociatedObject(object, key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
}

public extension NSObject {
    class func swizzle(original: Selector, swizzled: Selector) {
        guard let originalMethod = class_getInstanceMethod(self, original),
              let swizzledMethod = class_getInstanceMethod(self, swizzled) else { return }

        let didAddMethod = class_addMethod(self, original, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

        if didAddMethod {
            class_replaceMethod(self, swizzled, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}

