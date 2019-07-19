// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "XHTML",
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(name: "SwiftXHTML", type: .dynamic, targets: ["XHTML"]),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(url:"https://github.com/YOCKOW/SwiftBonaFideCharacterSet.git", from:"1.6.0"),
    .package(url:"https://github.com/YOCKOW/SwiftExtensions.git", from:"0.1.0"),
    .package(url:"https://github.com/YOCKOW/SwiftNetworkGear.git", from:"0.9.0"),
    .package(url:"https://github.com/YOCKOW/SwiftPredicate.git", from:"1.2.0"),
    .package(url:"https://github.com/YOCKOW/SwiftRanges.git", from: "3.0.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(name: "XHTML",
            dependencies: [
              "SwiftBonaFideCharacterSet",
              "SwiftYOCKOWExtensions",
              "SwiftNetworkGear",
              "SwiftPredicate",
              "SwiftRanges"
            ]),
    .target(name: "TestResources", dependencies: [], path: "Tests/TestResources"),
    .testTarget(name: "XHTMLTests",dependencies: ["XHTML", "TestResources"]),
  ],
  swiftLanguageVersions: [.v4, .v4_2, .v5]
)

