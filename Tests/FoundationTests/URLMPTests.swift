//
//  URLMPTests.swift
//  Maple
//
//  Created by cy on 2023/3/21.
//  Copyright © 2023 cy. All rights reserved.
//

@testable import Maple
import XCTest

#if canImport(Foundation)
import Foundation
final class URLMPTests: XCTestCase {
    var url = URL(string: "https://www.google.com")!
    let params = ["q": "swifter swift"]
    let queryUrl = URL(string: "https://www.google.com?q=swifter%20swift")!
    
    func testQueryParameters() {
        let url = URL(string: "https://www.google.com?q=swifter%20swift&steve=jobs&empty")!
        guard let parameters = url.mp.queryParameters else {
            XCTAssert(false)
            return
        }

        XCTAssertEqual(parameters.count, 2)
        XCTAssertEqual(parameters["q"], "swifter swift")
        XCTAssertEqual(parameters["steve"], "jobs")
        XCTAssertNil(parameters["empty"])
    }
    
    func testOptionalStringInitializer() {
        XCTAssertNil(URL(string: nil, relativeTo: nil))
        XCTAssertNil(URL(string: nil))

        let baseURL = URL(string: "https://www.example.com")
        XCTAssertNotNil(baseURL)
        XCTAssertNil(URL(string: nil, relativeTo: baseURL))

        let string = "/index.html"
        let optionalString: String? = string
        XCTAssertEqual(URL(string: optionalString, relativeTo: baseURL), URL(string: string, relativeTo: baseURL))
        XCTAssertEqual(
            URL(string: optionalString, relativeTo: baseURL)?.absoluteString,
            "https://www.example.com/index.html")
    }
    
    func testStringInitializer() throws {
        let testURL = try XCTUnwrap(URL(string: "https://google.com"))
        let extensionURL = URL(unsafeString: "https://google.com")
        XCTAssertEqual(testURL, extensionURL)
    }
    
    func testAppendingQueryParameters() {
        XCTAssertEqual(url.mp.appendingQueryParameters(params), queryUrl)
    }

    func testValueForQueryKey() {
        let url = URL(string: "https://google.com?code=12345&empty")!

        let codeResult = url.mp.queryValue(for: "code")
        let emptyResult = url.mp.queryValue(for: "empty")
        let otherResult = url.mp.queryValue(for: "other")

        XCTAssertEqual(codeResult, "12345")
        XCTAssertNil(emptyResult)
        XCTAssertNil(otherResult)
    }

    func testDeletingAllPathComponents() {
        let url = URL(string: "https://domain.com/path/other/")!
        let result = url.mp.deletingAllPathComponents()
        XCTAssertEqual(result.absoluteString, "https://domain.com/")

        let pathlessURL = URL(string: "https://domain.com")!
        let pathlessResult = pathlessURL.mp.deletingAllPathComponents()
        XCTAssertEqual(pathlessResult.absoluteString, "https://domain.com")
    }

    func testDropScheme() {
        let urls: [String: String?] = [
            "https://domain.com/path/other/": "domain.com/path/other/",
            "https://domain.com": "domain.com",
            "http://domain.com": "domain.com",
            "file://domain.com/image.jpeg": "domain.com/image.jpeg",
            "://apple.com": "apple.com",
            "//apple.com": "apple.com",
            "apple.com": "apple.com",
            "http://": nil,
            "//": "//"
        ]

        urls.forEach { input, expected in
            guard let url = URL(string: input) else { return XCTFail("Failed to initialize URL.") }
            XCTAssertEqual(url.mp.droppedScheme()?.absoluteString, expected, "input url: \(input)")
        }
    }
}
#endif
