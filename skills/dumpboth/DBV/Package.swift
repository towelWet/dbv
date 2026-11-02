// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "DBV",
    platforms: [.macOS(.v26)],
    products: [
        .library(name: "DBVCore", targets: ["DBVCore"]),
        .executable(name: "DBV", targets: ["DBVApp"]),
    ],
    targets: [
        .target(name: "DBVCore"),
        .target(
            name: "DBVOpenPanelModal",
            path: "Sources/DBVOpenPanelModal",
            publicHeadersPath: "include"
        ),
        .executableTarget(
            name: "DBVApp",
            dependencies: ["DBVCore", "DBVOpenPanelModal"]
        ),
        .testTarget(
            name: "DBVCoreTests",
            dependencies: ["DBVCore"],
            resources: [.copy("Fixtures")]
        ),
        .testTarget(
            name: "DBVAppTests",
            dependencies: ["DBVApp"],
            path: "Tests/DBVAppTests"
        ),
    ]
)
