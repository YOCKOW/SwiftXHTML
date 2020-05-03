// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "XHTML",
  platforms: [
    .macOS(.v10_15),
    .iOS(.v13),
    .watchOS(.v6),
    .tvOS(.v13),
  ],
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(name: "SwiftXHTML", type: .dynamic, targets: ["XHTML"]),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(url:"https://github.com/YOCKOW/SwiftBonaFideCharacterSet.git", from: "1.6.2"),
    .package(url:"https://github.com/YOCKOW/SwiftNetworkGear.git", "0.13.0"..<"2.0.0"),
    .package(url:"https://github.com/YOCKOW/SwiftRanges.git", from: "3.1.1"),
    .package(url:"https://github.com/YOCKOW/SwiftStringComposition.git", from: "2.0.0"),
    .package(url:"https://github.com/YOCKOW/SwiftUnicodeSupplement.git", from: "1.0.0"),
    .package(url:"https://github.com/YOCKOW/ySwiftExtensions.git", from: "1.0.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(name: "XHTML",
            dependencies: [
              "SwiftBonaFideCharacterSet",
              "SwiftNetworkGear",
              "SwiftRanges",
              "SwiftStringComposition",
              "SwiftUnicodeSupplement",
              "ySwiftExtensions",
            ]),
    .target(name: "TestResources", dependencies: [], path: "Tests/TestResources"),
    .testTarget(name: "XHTMLTests",dependencies: ["XHTML", "TestResources"]),
  ],
  swiftLanguageVersions: [.v5]
)


import Foundation
if ProcessInfo.processInfo.environment["YOCKOW_USE_LOCAL_PACKAGES"] != nil {
  func localPath(with url: String) -> String {
    guard let url = URL(string: url) else { fatalError("Unexpected URL.") }
    let dirName = url.deletingPathExtension().lastPathComponent
    return "../\(dirName)"
  }
  package.dependencies = package.dependencies.map { .package(path: localPath(with: $0.url)) }
}
