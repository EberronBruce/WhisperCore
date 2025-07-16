// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WhisperCore",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "WhisperCore",
            targets: ["WhisperCoreWrapper"]
        )
    ],
    targets: [
        .binaryTarget(name: "WhisperCore", path: "Frameworks/WhisperCore.xcframework"),
        .binaryTarget(name: "whisper", path: "Frameworks/whisper.xcframework"),
        .target(
            name: "WhisperCoreWrapper",
            dependencies: [
                .target(name: "WhisperCore"),
                .target(name: "whisper")
            ]
        )
    ]
)
