// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .enableExperimentalFeature("StrictConcurrency=complete")
]

let package = Package(
    name: "Maple",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
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
            resources: [
                .process("Resources")
            ],
            swiftSettings: swiftSettings
        ),
    ]
)
