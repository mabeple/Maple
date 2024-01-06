// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Maple",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13)
    ],
    products: [
        .library(name: "Maple", targets: ["Maple"])
    ],
    targets: [
        .target(
            name: "Maple",
            path: "Sources",
            exclude: ["Info.plist", "Maple.h"]
        ),
        .testTarget(
            name: "MapleTests",
            dependencies: ["Maple"],
            path: "Tests",
            exclude: ["Info.plist"],
            resources: [.process("ResourcesTests")]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
