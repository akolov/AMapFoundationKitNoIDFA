// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AMapFoundationKitNoIDFA",
  platforms: [.iOS(.v13)],
  products: [
    .library(
      name: "AMapFoundationKit",
      targets: ["AMapFoundationKit"]
    ),
  ],
  targets: [
    .binaryTarget(name: "AMapFoundationKit", path: "Vendor/AMapFoundationKit.xcframework")
  ]
)
