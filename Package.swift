// swift-tools-version:5.6
import PackageDescription
let package = Package(
    name: "swift-music-web-playground",
    platforms: [.macOS(.v11), .iOS(.v13)],
    products: [
        .executable(name: "MusicWebPlayground", targets: ["MusicWebPlayground"])
    ],
    dependencies: [
        .package(url: "https://github.com/TokamakUI/Tokamak.git", from: "0.10.0"),
    ],
    targets: [
        .executableTarget(
            name: "MusicWebPlayground",
            dependencies: [
                .product(name: "TokamakShim", package: "Tokamak"),
            ]),
        .testTarget(
            name: "MusicWebPlaygroundTests",
            dependencies: ["MusicWebPlayground"]
        ),
    ]
)
