// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PugiSwift",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PugiSwift",
            targets: ["PugiSwift"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "PugiSwift",
            dependencies: [
                "pugixml"
            ],
            swiftSettings: [
                .interoperabilityMode(.Cxx),
                .swiftLanguageMode(.v6),
                .unsafeFlags([
                    "-Xcc", "-std=c++11"
                ])
            ]),
        .target(
            name: "pugixml"),
        .testTarget(
            name: "PugiSwiftTests",
            dependencies: ["PugiSwift"],
            swiftSettings: [
                .interoperabilityMode(.Cxx),
                .swiftLanguageMode(.v6),
                .unsafeFlags([
                    "-Xcc", "-std=c++11"
                ])
            ]
        )
    ]
)
