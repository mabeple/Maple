//
//  Runtime.swift
//  Maple-iOS
//
//  Created by cy on 2024/5/7.
//  Copyright © 2024 cy. All rights reserved.
//

import Foundation

/// Association policy for associated objects.
///
/// This enum defines how an associated object is stored and managed
/// by the Objective-C runtime.
///
/// - Note:
///   All policies here are **non-atomic** for performance reasons.
///   They are suitable for typical UIKit / AppKit main-thread usage.
public enum AssociationPolicy {

    /// Retains the associated object (non-atomic).
    ///
    /// Equivalent to `strong, nonatomic` in Objective-C.
    /// The associated object’s lifetime is extended to match
    /// the lifetime of the host object.
    ///
    /// This is the **default and recommended policy** for most cases,
    /// including Swift reference types and value types (which are boxed).
    case retain
    
    /// Copies the associated object (non-atomic).
    ///
    /// Equivalent to `copy, nonatomic` in Objective-C.
    /// A copy of the object is stored at the time of association.
    ///
    /// Use this when associating:
    /// - Objective-C mutable types (`NSMutableString`, `NSMutableArray`, etc.)
    /// - Configuration or value snapshots that should not change
    ///   when the original object is mutated.
    ///
    /// - Important:
    ///   The object must correctly implement `NSCopying`.
    case copy
    
    /// Assigns the associated object **without retaining it** (unsafe).
    ///
    /// Equivalent to `unsafe_unretained` in Objective-C.
    ///
    /// - Warning:
    ///   This is **NOT** the same as `weak`.
    ///   The reference is **not zeroed** when the associated object
    ///   is deallocated, and may become a dangling pointer.
    ///
    /// Use this policy **only when the associated object's lifetime
    /// is guaranteed** to exceed the lifetime of the host object.
    ///
    /// In most cases, prefer `.retain` or implement a boxed weak reference.
    case assign

    /// Converts the Swift association policy to the corresponding
    /// Objective-C runtime association policy.
    var objc: objc_AssociationPolicy {
        switch self {
        case .retain: return .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        case .copy:   return .OBJC_ASSOCIATION_COPY_NONATOMIC
        case .assign: return .OBJC_ASSOCIATION_ASSIGN
        }
    }
}


/// Retrieves an associated object for a given key.
///
/// - Parameters:
///   - object: The host object from which to retrieve the association.
///   - key: A unique pointer used as the association key.
/// - Returns:
///   The associated value cast to type `T`, or `nil` if no association exists.
///
/// - Note:
///   On Swift versions prior to 5.3, a compiler/runtime issue required
///   an additional cast to `AnyObject`.
///   This implementation preserves compatibility with older runtimes.
public func getAssociatedObject<T>(_ object: Any, _ key: UnsafeRawPointer) -> T? {
    if #available(iOS 14, macOS 11, watchOS 7, tvOS 14, *) { // swift 5.3 fixed this issue (https://github.com/apple/swift/issues/46456)
        return objc_getAssociatedObject(object, key) as? T
    } else {
        return objc_getAssociatedObject(object, key) as AnyObject as? T
    }
}

/// Sets an associated object for a given key using the specified policy.
///
/// - Parameters:
///   - object: The host object to associate the value with.
///   - key: A unique pointer used as the association key.
///   - value: The value to associate with the host object.
///   - policy: The association policy to use. Defaults to `.retain`.
///
/// - Note:
///   Value types (such as Swift `struct`s) are automatically boxed
///   by the Swift runtime when stored as associated objects.
public func setAssociatedObject<T>(
    _ object: Any,
    _ key: UnsafeRawPointer,
    _ value: T,
    policy: AssociationPolicy = .retain
) {
    objc_setAssociatedObject(object, key, value, policy.objc)
}

/// Swizzles two instance methods on a class.
///
/// This method exchanges the implementations of two selectors.
/// If the original selector does not exist on the class (but exists
/// on a superclass), it is safely added before performing the swap.
///
/// - Parameters:
///   - original: The selector of the original method.
///   - swizzled: The selector of the replacement method.
///
/// - Important:
///   Method swizzling should be performed **once** per class,
///   typically during application startup.
///   The swizzled method must call the original implementation
///   (after swizzling) to preserve expected behavior.
public extension NSObject {
    class func swizzle(original: Selector, swizzled: Selector) {
        guard let originalMethod = class_getInstanceMethod(self, original),
              let swizzledMethod = class_getInstanceMethod(self, swizzled)
        else { return }

        let didAddMethod = class_addMethod(
            self,
            original,
            method_getImplementation(swizzledMethod),
            method_getTypeEncoding(swizzledMethod)
        )

        if didAddMethod {
            class_replaceMethod(
                self,
                swizzled,
                method_getImplementation(originalMethod),
                method_getTypeEncoding(originalMethod)
            )
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}
