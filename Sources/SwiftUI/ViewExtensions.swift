#if canImport(SwiftUI)
import SwiftUI

public extension View {
    
    /// Applies a transform when the condition is true.
    ///
    ///     Text("Maple")
    ///         .if(isHighlighted) { $0.bold() }
    ///
    /// - Parameters:
    ///   - condition: A Boolean value that determines whether the transform is applied.
    ///   - transform: The transform to apply when the condition is true.
    /// - Returns: Either the transformed view or the original view.
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    /// Applies a transform when the optional contains a value.
    ///
    ///     Text(title)
    ///         .ifLet(subtitle) { view, subtitle in
    ///             view.help(subtitle)
    ///         }
    ///
    /// - Parameters:
    ///   - value: The optional value to unwrap.
    ///   - transform: The transform to apply when the value is non-nil.
    /// - Returns: Either the transformed view or the original view.
    @ViewBuilder
    func ifLet<Value, Content: View>(_ value: Value?, transform: (Self, Value) -> Content) -> some View {
        if let value {
            transform(self, value)
        } else {
            self
        }
    }
    
    /// Hides the view and optionally removes it from the hierarchy.
    ///
    ///     Text("Maple")
    ///         .isHidden(isLoading, remove: false)
    ///
    /// - Parameters:
    ///   - hidden: A Boolean value that determines whether the view should be hidden.
    ///   - remove: Whether to remove the view instead of only hiding it.
    /// - Returns: Either the hidden view, an empty view, or the original view.
    @ViewBuilder
    func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if remove {
                EmptyView()
            } else {
                self.hidden()
            }
        } else {
            self
        }
    }
}

#endif
