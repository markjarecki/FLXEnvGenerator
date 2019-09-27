// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FLXEnvGenerator",
    products: [
        .executable(name: "envgenerator", targets: ["FLXEnvGenerator"]),
        .library(name: "FLXEnvGeneratorCore", targets: ["FLXEnvGeneratorCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-package-manager.git", .branch("swift-5.0-branch")),
        .package(url: "https://github.com/kylef/PathKit.git", from: "1.0.0"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "FLXEnvGenerator",
            dependencies: [
                "FLXEnvGeneratorCore",
            ]),
        .target(
            name: "FLXEnvGeneratorCore",
            dependencies: [
                "SwiftPM",
                "PathKit",
                "Yams",
            ]),
        .testTarget(
            name: "FLXEnvGeneratorTests",
            dependencies: [
                "FLXEnvGeneratorCore",
                "SwiftPM",
                "PathKit",
                "Yams",
            ],
            exclude: [
                "Environments"
            ]),
    ]
)
