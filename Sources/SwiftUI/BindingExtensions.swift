#if canImport(SwiftUI)
import SwiftUI

extension Binding: MapleCompatibleValue { }

public extension MapleWrapper {
    
    /// Creates a non-optional binding by providing a fallback value.
    ///
    ///     let name = $optionalName.mp.withDefault("")
    ///
    /// - Parameter defaultValue: The value returned when the wrapped optional is `nil`.
    /// - Returns: A non-optional binding backed by the original optional binding.
    func withDefault<Wrapped>(_ defaultValue: Wrapped) -> Binding<Wrapped> where Base == Binding<Wrapped?>, Wrapped: Sendable {
        Binding<Wrapped>(
            get: { base.wrappedValue ?? defaultValue },
            set: { base.wrappedValue = $0 }
        )
    }
    
    /// Creates a derived binding by mapping get and set operations.
    ///
    ///     let countText = $count.mp.map(
    ///         get: { String($0) },
    ///         set: { Int($0) ?? 0 }
    ///     )
    ///
    /// - Parameters:
    ///   - get: Converts the wrapped value into the derived value.
    ///   - set: Converts the derived value back into the wrapped value.
    /// - Returns: A transformed binding.
    func map<Value, Mapped>(get: @escaping @Sendable (Value) -> Mapped,
                            set: @escaping @Sendable (Mapped) -> Value) -> Binding<Mapped> where Base == Binding<Value>, Value: Sendable, Mapped: Sendable {
        Binding<Mapped>(
            get: { get(base.wrappedValue) },
            set: { base.wrappedValue = set($0) }
        )
    }
    
    /// Executes a handler after assigning a new value to the binding.
    ///
    ///     let tracked = $username.mp.didSet { print($0) }
    ///
    /// - Parameter handler: A closure invoked after the new value is stored.
    /// - Returns: A binding that mirrors the original one and reports changes.
    func didSet<Value>(_ handler: @escaping @Sendable (Value) -> Void) -> Binding<Value> where Base == Binding<Value>, Value: Sendable {
        Binding<Value>(
            get: { base.wrappedValue },
            set: { newValue in
                base.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
    
    /// Creates a Boolean binding that tracks whether the optional contains a value.
    ///
    /// Setting the returned binding to `false` clears the wrapped optional.
    /// Setting it to `true` leaves the wrapped value unchanged.
    ///
    ///     let isPresented = $selectedItem.mp.isPresent()
    ///
    /// - Returns: A Boolean binding that reflects the optional's presence.
    func isPresent<Wrapped>() -> Binding<Bool> where Base == Binding<Wrapped?>, Wrapped: Sendable {
        Binding<Bool>(
            get: { base.wrappedValue != nil },
            set: { isPresented in
                if !isPresented {
                    base.wrappedValue = nil
                }
            }
        )
    }
}

#endif
