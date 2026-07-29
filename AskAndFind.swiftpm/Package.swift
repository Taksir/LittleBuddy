// swift-tools-version: 5.7

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "AskAndFind",
    platforms: [
        .iOS("17.0")
    ],
    products: [
        .iOSApplication(
            name: "Ask & Find",
            targets: ["AppModule"],
            bundleIdentifier: "com.taksir.askandfind.playground",
            displayVersion: "0.2.0",
            bundleVersion: "2",
            supportedDeviceFamilies: [
                .pad
            ],
            supportedInterfaceOrientations: [
                .landscapeLeft,
                .landscapeRight
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "Sources/AppModule"
        )
    ]
)
