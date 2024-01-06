// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Maple",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
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
