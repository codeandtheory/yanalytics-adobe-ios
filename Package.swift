// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "YAnalyticsAdobe",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "YAnalyticsAdobe",
            targets: ["YAnalyticsAdobe"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/adobe/aepsdk-analytics-ios.git",
            .upToNextMajor(from: "3.0.0")
        ),
        .package(
            url: "https://github.com/yml-org/yanalytics-ios.git",
            .upToNextMajor(from: "1.2.0")
        )
    ],
    targets: [
        .target(
            name: "YAnalyticsAdobe",
            dependencies: [
                .product(name: "AEPAnalytics", package: "aepsdk-analytics-ios"),
                .product(name: "YAnalytics", package: "yanalytics-ios")
            ]
        ),
        .testTarget(
            name: "YAnalyticsAdobeTests",
            dependencies: ["YAnalyticsAdobe"]
        )
    ]
)
