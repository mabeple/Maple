//
//  URLExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

import Foundation
import Testing
@testable import Maple

@Suite("URL Extensions Test Suite")
struct URLExtensionTests {
    
    // MARK: - Protocol Conformance
    
    @Test("URL should conform to MapleCompatibleValue")
    func testURLConformsToMapleCompatibleValue() {
        let url = URL(string: "https://example.com")!
        let wrapper = url.mp
        #expect(wrapper.base == url)
    }
    
    // MARK: - Property: queryParameters
    
    @Test("queryParameters should return dictionary of query parameters")
    func testQueryParameters() {
        // Test with query parameters
        let url1 = URL(string: "https://example.com?foo=bar&baz=qux")!
        let params1 = url1.mp.queryParameters
        #expect(params1 != nil)
        #expect(params1?["foo"] == "bar")
        #expect(params1?["baz"] == "qux")
        
        // Test with single parameter
        let url2 = URL(string: "https://example.com?key=value")!
        let params2 = url2.mp.queryParameters
        #expect(params2?["key"] == "value")
        
        // Test with no query parameters
        let url3 = URL(string: "https://example.com")!
        let params3 = url3.mp.queryParameters
        #expect(params3 == nil)
        
        // Test with empty query
        let url4 = URL(string: "https://example.com?")!
        let params4 = url4.mp.queryParameters
        #expect(params4 == nil || params4?.isEmpty == true)
        
        // Test with multiple values and special characters
        let url5 = URL(string: "https://example.com?name=John%20Doe&age=30")!
        let params5 = url5.mp.queryParameters
        #expect(params5?["name"] == "John Doe")
        #expect(params5?["age"] == "30")
    }
    
    // MARK: - Initializer: init(string:relativeTo:)
    
    @Test("init(string:relativeTo:) should handle optional string parameter")
    func testInitWithOptionalString() {
        let baseURL = URL(string: "https://example.com")!
        
        // Test with valid relative string (explicit optional)
        let optionalString1: String? = "path/to/resource"
        let url1 = URL(string: optionalString1, relativeTo: baseURL)
        #expect(url1 != nil)
        #expect(url1?.absoluteString.contains("path/to/resource") == true)
        
        // Test with nil string
        let url2 = URL(string: nil, relativeTo: baseURL)
        #expect(url2 == nil)
        
        // Test with absolute string (explicit optional)
        let optionalString3: String? = "https://another.com"
        let url3 = URL(string: optionalString3, relativeTo: baseURL)
        #expect(url3 != nil)
        #expect(url3?.host == "another.com")
        
        // Test without base URL (explicit optional)
        let optionalString4: String? = "https://example.com"
        let url4 = URL(string: optionalString4)
        #expect(url4 != nil)
        
        // Test with valid optional string and nil relativeTo
        let optionalString5: String? = "/api/endpoint"
        let url5 = URL(string: optionalString5, relativeTo: nil)
        #expect(url5 != nil)
    }
    
    // MARK: - Initializer: init(unsafeString:)
    
    @Test("init(unsafeString:) should create URL from string")
    func testInitUnsafeString() {
        let url = URL(unsafeString: "https://example.com")
        #expect(url.absoluteString == "https://example.com")
        
        let urlWithPath = URL(unsafeString: "https://example.com/path")
        #expect(urlWithPath.path == "/path")
        
        let urlWithQuery = URL(unsafeString: "https://example.com?key=value")
        #expect(urlWithQuery.query == "key=value")
    }
    
    // MARK: - Method: appendingQueryParameters
    
    @Test("appendingQueryParameters should add query parameters to URL")
    func testAppendingQueryParameters() {
        let url = URL(string: "https://google.com")!
        
        // Test appending to URL without existing parameters
        let params1 = ["q": "Swift", "lang": "en"]
        let newUrl1 = url.mp.appendingQueryParameters(params1)
        #expect(newUrl1.absoluteString.contains("q=Swift"))
        #expect(newUrl1.absoluteString.contains("lang=en"))
        
        // Test appending to URL with existing parameters
        let url2 = URL(string: "https://google.com?existing=value")!
        let params2 = ["new": "param"]
        let newUrl2 = url2.mp.appendingQueryParameters(params2)
        #expect(newUrl2.absoluteString.contains("existing=value"))
        #expect(newUrl2.absoluteString.contains("new=param"))
        
        // Test with empty dictionary
        let params3: [String: String] = [:]
        let newUrl3 = url.mp.appendingQueryParameters(params3)
        #expect(newUrl3.host == url.host)
        
        // Test with special characters
        let params4 = ["text": "Hello World"]
        let newUrl4 = url.mp.appendingQueryParameters(params4)
        #expect(newUrl4.absoluteString.contains("text="))
    }
    
    // MARK: - Method: queryValue
    
    @Test("queryValue should get value for query parameter key")
    func testQueryValue() {
        let url = URL(string: "https://google.com?code=12345&name=test")!
        
        // Test existing key
        let value1 = url.mp.queryValue(for: "code")
        #expect(value1 == "12345")
        
        let value2 = url.mp.queryValue(for: "name")
        #expect(value2 == "test")
        
        // Test non-existing key
        let value3 = url.mp.queryValue(for: "nonexistent")
        #expect(value3 == nil)
        
        // Test URL without query parameters
        let url2 = URL(string: "https://google.com")!
        let value4 = url2.mp.queryValue(for: "key")
        #expect(value4 == nil)
        
        // Test with encoded characters
        let url3 = URL(string: "https://example.com?message=Hello%20World")!
        let value5 = url3.mp.queryValue(for: "message")
        #expect(value5 == "Hello World")
    }
    
    // MARK: - Method: deletingAllPathComponents
    
    @Test("deletingAllPathComponents should remove all path components")
    func testDeletingAllPathComponents() {
        // Test with multiple path components
        let url1 = URL(string: "https://domain.com/path/to/resource")!
        let result1 = url1.mp.deletingAllPathComponents()
        #expect(result1.absoluteString == "https://domain.com/")
        
        // Test with single path component
        let url2 = URL(string: "https://domain.com/path")!
        let result2 = url2.mp.deletingAllPathComponents()
        #expect(result2.absoluteString == "https://domain.com/")
        
        // Test with no path components
        let url3 = URL(string: "https://domain.com")!
        let result3 = url3.mp.deletingAllPathComponents()
        #expect(result3.absoluteString == url3.absoluteString)
        
        // Test with trailing slash
        let url4 = URL(string: "https://domain.com/")!
        let result4 = url4.mp.deletingAllPathComponents()
        #expect(result4.host == "domain.com")
        
        // Test with query parameters
        let url5 = URL(string: "https://domain.com/path?key=value")!
        let result5 = url5.mp.deletingAllPathComponents()
        #expect(result5.absoluteString.contains("domain.com"))
    }
    
    // MARK: - Method: droppedScheme
    
    @Test("droppedScheme should return URL without scheme")
    func testDroppedScheme() {
        // Test with https scheme
        let url1 = URL(string: "https://domain.com")!
        let result1 = url1.mp.droppedScheme()
        #expect(result1?.absoluteString == "domain.com")
        
        // Test with http scheme
        let url2 = URL(string: "http://domain.com")!
        let result2 = url2.mp.droppedScheme()
        #expect(result2?.absoluteString == "domain.com")
        
        // Test with path
        let url3 = URL(string: "https://domain.com/path")!
        let result3 = url3.mp.droppedScheme()
        #expect(result3?.absoluteString == "domain.com/path")
        
        // Test with ftp scheme
        let url4 = URL(string: "ftp://server.com")!
        let result4 = url4.mp.droppedScheme()
        #expect(result4?.absoluteString == "server.com")
        
        // Test with custom scheme
        let url5 = URL(string: "myapp://action")!
        let result5 = url5.mp.droppedScheme()
        #expect(result5 != nil)
        #expect(result5?.absoluteString.contains("myapp") == false)
        
        // Test with relative URL (no scheme, has path)
        let baseURL = URL(string: "https://example.com")!
        let url6 = URL(string: "path/file", relativeTo: baseURL)!
        let result6 = url6.mp.droppedScheme()
        #expect(result6 != nil)
        
        // Test with file path (no scheme, no host)
        let url7 = URL(fileURLWithPath: "/path/to/file")
        let result7 = url7.mp.droppedScheme()
        #expect(result7 != nil)
        
        // Test with protocol-relative URL (no scheme, but has host)
        let url8 = URL(string: "//domain.com")!
        let result8 = url8.mp.droppedScheme()
        #expect(result8 != nil)
        #expect(result8?.absoluteString == "domain.com")
        
        // Test with protocol-relative URL with path
        let url9 = URL(string: "//example.com/path/to/resource")!
        let result9 = url9.mp.droppedScheme()
        #expect(result9 != nil)
        #expect(result9?.absoluteString.contains("example.com") == true)
    }
}
