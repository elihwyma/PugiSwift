// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "PugiSwift",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6),
        .macCatalyst(.v13),
        .tvOS(.v13),
        .visionOS(.v1)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PugiSwift",
            targets: ["PugiSwift"]),
        .executable(
            name: "PugiSwiftDemo",
            targets: ["PugiSwiftDemo"]),
        .executable(
            name: "swiftxsd",
            targets: ["swiftxsd"])
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0-latest"),
        .package(url: "https://github.com/stackotter/swift-macro-toolkit.git", from: "0.6.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "PugiSwiftDemo",
            dependencies: [
                "PugiSwift"
            ],
            swiftSettings: [
                .interoperabilityMode(.Cxx),
                .swiftLanguageMode(.v6)
            ]
        ),
        .executableTarget(
            name: "swiftxsd",
            dependencies: [
                "PugiSwift"
            ],
            swiftSettings: [
                .interoperabilityMode(.Cxx),
                .swiftLanguageMode(.v6)
            ]
        ),
        .target(
            name: "PugiSwift",
            dependencies: [
                "pugixml",
                "PugiSwiftMacros"
            ],
            swiftSettings: [
                .interoperabilityMode(.Cxx),
                .swiftLanguageMode(.v6)
            ]),
        .target(
            name: "pugixml"),
        .macro(
            name: "PugiSwiftMacros",
            dependencies: [
                .product(name: "MacroToolkit", package: "swift-macro-toolkit"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .testTarget(
            name: "PugiSwiftTests",
            dependencies: ["PugiSwift"],
            swiftSettings: [
                .interoperabilityMode(.Cxx),
                .swiftLanguageMode(.v6)
            ]
        )
    ]
)

#if canImport(PackageConfig)
import PackageConfig

let metadata = PackageConfiguration([
  "description": "Swifty wrapper for pugixml",
  "authors": [
    ["name": "Amelia While",
     "email": "me@anamy.gay" ]
  ]
]).write()

#endif
