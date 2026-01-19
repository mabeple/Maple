//
//  BinaryIntegerExtensionsTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//  Copyright © 2026 cy. All rights reserved.
//

import XCTest
@testable import Maple

#if canImport(Foundation)
final class BinaryIntegerExtensionsTests: XCTestCase {
    func testBytes() {
        // Test Int8
        let int8Value: Int8 = -128
        let int8Bytes = int8Value.mp.bytes
        XCTAssertEqual(int8Bytes.count, MemoryLayout<Int8>.size)
        XCTAssertEqual(int8Bytes, [0x80])
        
        let int8Value2: Int8 = 127
        let int8Bytes2 = int8Value2.mp.bytes
        XCTAssertEqual(int8Bytes2, [0x7F])
        
        let int8Value3: Int8 = 0
        let int8Bytes3 = int8Value3.mp.bytes
        XCTAssertEqual(int8Bytes3, [0x00])
        
        // Test Int16
        let int16Value: Int16 = -128
        let int16Bytes = int16Value.mp.bytes
        XCTAssertEqual(int16Bytes.count, MemoryLayout<Int16>.size)
        // -128 in two's complement: 0xFF80 (big-endian)
        XCTAssertEqual(int16Bytes, [0xFF, 0x80])
        
        let int16Value2: Int16 = 255
        let int16Bytes2 = int16Value2.mp.bytes
        XCTAssertEqual(int16Bytes2, [0x00, 0xFF])
        
        let int16Value3: Int16 = 0x1234
        let int16Bytes3 = int16Value3.mp.bytes
        XCTAssertEqual(int16Bytes3, [0x12, 0x34])
        
        // Test Int32
        let int32Value: Int32 = 0x12345678
        let int32Bytes = int32Value.mp.bytes
        XCTAssertEqual(int32Bytes.count, MemoryLayout<Int32>.size)
        // 0x12345678 in big-endian: [0x12, 0x34, 0x56, 0x78]
        XCTAssertEqual(int32Bytes, [0x12, 0x34, 0x56, 0x78])
        
        let int32Value2: Int32 = -1
        let int32Bytes2 = int32Value2.mp.bytes
        XCTAssertEqual(int32Bytes2, [0xFF, 0xFF, 0xFF, 0xFF])
        
        // Test Int64
        let int64Value: Int64 = 0x0123456789ABCDEF
        let int64Bytes = int64Value.mp.bytes
        XCTAssertEqual(int64Bytes.count, MemoryLayout<Int64>.size)
        // 0x0123456789ABCDEF in big-endian: [0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF]
        XCTAssertEqual(int64Bytes, [0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF])
        
        // Test UInt8
        let uint8Value: UInt8 = 255
        let uint8Bytes = uint8Value.mp.bytes
        XCTAssertEqual(uint8Bytes.count, MemoryLayout<UInt8>.size)
        XCTAssertEqual(uint8Bytes, [0xFF])
        
        let uint8Value2: UInt8 = 0
        let uint8Bytes2 = uint8Value2.mp.bytes
        XCTAssertEqual(uint8Bytes2, [0x00])
        
        // Test UInt16
        let uint16Value: UInt16 = 0x1234
        let uint16Bytes = uint16Value.mp.bytes
        XCTAssertEqual(uint16Bytes.count, MemoryLayout<UInt16>.size)
        XCTAssertEqual(uint16Bytes, [0x12, 0x34])
        
        // Test UInt32
        let uint32Value: UInt32 = 0x12345678
        let uint32Bytes = uint32Value.mp.bytes
        XCTAssertEqual(uint32Bytes.count, MemoryLayout<UInt32>.size)
        XCTAssertEqual(uint32Bytes, [0x12, 0x34, 0x56, 0x78])
        
        // Test UInt64
        let uint64Value: UInt64 = 0x0123456789ABCDEF
        let uint64Bytes = uint64Value.mp.bytes
        XCTAssertEqual(uint64Bytes.count, MemoryLayout<UInt64>.size)
        XCTAssertEqual(uint64Bytes, [0x01, 0x23, 0x45, 0x67, 0x89, 0xAB, 0xCD, 0xEF])
        
        // Test Int (platform-dependent size)
        let intValue: Int = 0x12345678
        let intBytes = intValue.mp.bytes
        XCTAssertEqual(intBytes.count, MemoryLayout<Int>.size)
        
        // Test zero
        let zeroInt: Int = 0
        let zeroBytes = zeroInt.mp.bytes
        XCTAssertEqual(zeroBytes.count, MemoryLayout<Int>.size)
        XCTAssertEqual(zeroBytes, Array(repeating: 0x00, count: MemoryLayout<Int>.size))
    }
    
    func testBytesRoundTrip() {
        // Test that we can reconstruct the value from bytes (big-endian)
        let testValues: [Int32] = [0, 1, -1, 0x12345678, -0x12345678, Int32.max, Int32.min]
        
        for originalValue in testValues {
            let bytes = originalValue.mp.bytes
            
            // Reconstruct from bytes (big-endian)
            var reconstructed: Int32 = 0
            for (index, byte) in bytes.enumerated() {
                reconstructed |= Int32(byte) << (8 * (bytes.count - 1 - index))
            }
            
            XCTAssertEqual(reconstructed, originalValue, "Failed for value: \(originalValue)")
        }
        
        // Test UInt32
        let uint32Value: UInt32 = 0x12345678
        let uint32Bytes = uint32Value.mp.bytes
        var reconstructedUInt32: UInt32 = 0
        for (index, byte) in uint32Bytes.enumerated() {
            reconstructedUInt32 |= UInt32(byte) << (8 * (UInt32(uint32Bytes.count - 1 - index)))
        }
        XCTAssertEqual(reconstructedUInt32, uint32Value)
    }
}
#endif
