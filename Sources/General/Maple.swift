//
//  Maple.swift
//  Maple
//
//  Created by cy on 2020/4/5.
//

import Foundation

/// A generic wrapper that provides a namespace for extending types without polluting their native namespace.
///
/// `MapleWrapper` is used to create a separate namespace (`mp`) for adding custom functionality
/// to both reference types (classes) and value types (structs, enums) without conflicting with
/// existing members or third-party extensions.
///
/// ## Usage
///
/// ```swift
/// // For reference types
/// class MyClass: MapleCompatible {
///     var name: String
/// }
///
/// extension MapleWrapper where Base: MyClass {
///     func greet() -> String {
///         return "Hello, \(base.name)"
///     }
/// }
///
/// let obj = MyClass()
/// obj.mp.greet() // Access through the mp namespace
/// ```
///
/// - Note: This struct is marked as `@unchecked Sendable` to support concurrent access patterns.
public struct MapleWrapper<Base>: @unchecked Sendable {
    /// The underlying wrapped value.
    public let base: Base
    
    /// Creates a new wrapper around the given base value.
    ///
    /// - Parameter base: The value to wrap.
    public init(_ base: Base) {
        self.base = base
    }
}

/// A protocol that reference types (classes) conform to in order to gain access to the `mp` namespace.
///
/// By conforming to this protocol, a class automatically gets access to the `mp` computed property,
/// which provides a `MapleWrapper` instance that can be used for namespaced extensions.
///
/// ## Example
///
/// ```swift
/// class MyService: MapleCompatible {
///     var configuration: String
/// }
///
/// extension MapleWrapper where Base: MyService {
///     func configure() {
///         // Custom configuration logic
///     }
/// }
///
/// let service = MyService()
/// service.mp.configure()
/// ```
///
/// - Note: This protocol is restricted to reference types (classes) with the `AnyObject` constraint.
public protocol MapleCompatible: AnyObject { }

extension MapleCompatible {
    /// A computed property that provides access to a `MapleWrapper` instance wrapping `self`.
    ///
    /// The getter creates a new `MapleWrapper` instance each time it's accessed, allowing
    /// you to use namespaced extensions without affecting the original type's interface.
    ///
    /// The setter is provided but does nothing, maintaining the property's mutability
    /// characteristics without side effects.
    ///
    /// - Returns: A `MapleWrapper` wrapping the current instance.
    public var mp: MapleWrapper<Self> {
        get { MapleWrapper(self) }
        set { }
    }
}

/// A protocol that value types (structs, enums) conform to in order to gain access to the `mp` namespace.
///
/// Similar to `MapleCompatible`, but designed for value types. Conforming types automatically
/// get access to the `mp` computed property for namespaced extensions.
///
/// ## Example
///
/// ```swift
/// struct Point: MapleCompatibleValue {
///     var x: Double
///     var y: Double
/// }
///
/// extension MapleWrapper where Base == Point {
///     func distance() -> Double {
///         return sqrt(base.x * base.x + base.y * base.y)
///     }
/// }
///
/// let point = Point(x: 3, y: 4)
/// let distance = point.mp.distance() // Returns 5.0
/// ```
public protocol MapleCompatibleValue { }

extension MapleCompatibleValue {
    /// A computed property that provides access to a `MapleWrapper` instance wrapping `self`.
    ///
    /// For value types, each access to this property creates a new wrapper containing a copy
    /// of the current value, preserving Swift's value semantics.
    ///
    /// The setter is provided but does nothing, maintaining the property's mutability
    /// characteristics without side effects.
    ///
    /// - Returns: A `MapleWrapper` wrapping a copy of the current value.
    public var mp: MapleWrapper<Self> {
        get { MapleWrapper(self) }
        set { }
    }
}
