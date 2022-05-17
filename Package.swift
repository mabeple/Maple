// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Maple",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_10)
    ],
    products: [
        .library(name: "Maple", targets: ["Maple"])
    ],
    targets: [
        .target(name: "Maple", path: "Sources"),
        .testTarget(name: "MapleTests", dependencies: ["Maple"]),
    ]
)
