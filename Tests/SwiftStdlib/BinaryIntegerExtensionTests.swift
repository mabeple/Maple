//
//  BinaryIntegerExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

@Suite("BinaryInteger Extensions Test Suite")
struct BinaryIntegerExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("BinaryInteger should have mp property")
    func testBinaryIntegerHasMPProperty() {
        let int: Int = 42
        let wrapper = int.mp
        #expect(wrapper.base == int)
    }
    
    // MARK: - Property: bytes
    
    @Test("bytes should return raw bytes of integer")
    func testBytes() {
        // Test with Int16
        let int16: Int16 = -128
        let bytes16 = int16.mp.bytes
        #expect(bytes16.count == 2)
        #expect(bytes16 == [255, 128])
        
        // Test with Int16 positive
        let int16Pos: Int16 = 128
        let bytes16Pos = int16Pos.mp.bytes
        #expect(bytes16Pos.count == 2)
        
        // Test with Int
        let int: Int = 0x12345678
        let bytes = int.mp.bytes
        #expect(bytes.count == MemoryLayout<Int>.size)
        
        // Test with UInt8
        let uint8: UInt8 = 255
        let bytes8 = uint8.mp.bytes
        #expect(bytes8.count == 1)
        #expect(bytes8[0] == 255)
        
        // Test with Int8
        let int8: Int8 = -1
        let bytes8Signed = int8.mp.bytes
        #expect(bytes8Signed.count == 1)
        #expect(bytes8Signed[0] == 255)
        
        // Test with zero
        let zero: Int = 0
        let zeroBytes = zero.mp.bytes
        #expect(zeroBytes.count == MemoryLayout<Int>.size)
        #expect(zeroBytes.allSatisfy { $0 == 0 })
    }
}
