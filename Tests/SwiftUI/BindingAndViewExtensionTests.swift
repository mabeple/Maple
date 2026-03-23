#if canImport(SwiftUI)
import SwiftUI
import Testing
@testable import Maple

@Suite("Binding Extensions Test Suite")
struct BindingExtensionTests {
    
    final class Box<Value>: @unchecked Sendable {
        var value: Value
        
        init(_ value: Value) {
            self.value = value
        }
    }
    
    @Test("Binding should conform to MapleCompatibleValue")
    func testBindingConformsToMapleCompatibleValue() {
        let binding = Binding.constant("Maple")
        #expect(binding.mp.base.wrappedValue == "Maple")
    }
    
    @Test("withDefault should expose fallback and write through")
    func testWithDefault() {
        let storage = Box<String?>(nil)
        let binding = Binding<String?>(
            get: { storage.value },
            set: { storage.value = $0 }
        )
        
        let defaulted = binding.mp.withDefault("Fallback")
        #expect(defaulted.wrappedValue == "Fallback")
        
        defaulted.wrappedValue = "Maple"
        #expect(storage.value == "Maple")
    }
    
    @Test("map should transform get and set")
    func testMap() {
        let storage = Box(21)
        let binding = Binding<Int>(
            get: { storage.value },
            set: { storage.value = $0 }
        )
        
        let mapped = binding.mp.map(
            get: { String($0) },
            set: { Int($0) ?? 0 }
        )
        
        #expect(mapped.wrappedValue == "21")
        mapped.wrappedValue = "34"
        #expect(storage.value == 34)
    }
    
    @Test("didSet should invoke the handler with new values")
    func testDidSet() {
        let storage = Box("A")
        let captured = Box([String]())
        let binding = Binding<String>(
            get: { storage.value },
            set: { storage.value = $0 }
        )
        
        let tracked = binding.mp.didSet { newValue in
            captured.value.append(newValue)
        }
        
        tracked.wrappedValue = "B"
        #expect(storage.value == "B")
        #expect(captured.value == ["B"])
    }
    
    @Test("isPresent should reflect and clear optional bindings")
    func testIsPresent() {
        let storage = Box<String?>("Maple")
        let binding = Binding<String?>(
            get: { storage.value },
            set: { storage.value = $0 }
        )
        
        let isPresent = binding.mp.isPresent()
        #expect(isPresent.wrappedValue)
        
        isPresent.wrappedValue = false
        #expect(storage.value == nil)
        #expect(!isPresent.wrappedValue)
    }
}

@Suite("View Extensions Test Suite")
@MainActor
struct ViewExtensionTests {
    
    private func buildsView<V: View>(_ view: V) -> Bool {
        _ = view
        return true
    }
    
    @Test("if should compose a view when the condition is true")
    func testIf() {
        let view = Text("Maple").if(true) { $0.bold() }
        #expect(buildsView(view))
    }
    
    @Test("ifLet should compose a view when the optional has a value")
    func testIfLet() {
        let view = Text("Maple").ifLet("Subtitle") { base, subtitle in
            base.help(subtitle)
        }
        #expect(buildsView(view))
    }
    
    @Test("isHidden should compose hidden and removed variants")
    func testIsHidden() {
        let hiddenView = Text("Maple").isHidden(true)
        let removedView = Text("Maple").isHidden(true, remove: true)
        let visibleView = Text("Maple").isHidden(false)
        
        #expect(buildsView(hiddenView))
        #expect(buildsView(removedView))
        #expect(buildsView(visibleView))
    }
}

#endif
