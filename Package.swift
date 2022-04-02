// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EasyPlaceholderView",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(name: "EasyPlaceholderView", targets: ["EasyPlaceholderView"])
    ],
    dependencies: [
        .package(url: "https://github.com/moliya/EasyCompatible.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "EasyPlaceholderView", dependencies: ["EasyCompatible"], path: "Sources")
    ],
    swiftLanguageVersions: [.v5]
)
