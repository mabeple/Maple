// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .enableExperimentalFeature("StrictConcurrency=complete")
]

let package = Package(
    name: "Maple",
    platforms: [
        .iOS(.v26),
        .macOS(.v26)
    ],
    products: [
        .library(name: "Maple", targets: ["Maple"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.4.5"),
    ],
    targets: [
        .target(
            name: "Maple",
            path: "Sources",
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "MapleTests",
            dependencies: ["Maple"],
            path: "Tests",
            swiftSettings: swiftSettings
        ),
    ]
)
