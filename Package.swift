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
        .package(url: "https://github.com/fwcd/swift-music-theory.git", from: "0.1.0"),
    ],
    targets: [
        .executableTarget(
            name: "MusicWebPlayground",
            dependencies: [
                .product(name: "TokamakShim", package: "Tokamak"),
                .product(name: "MusicTheory", package: "swift-music-theory"),
            ]),
        .testTarget(
            name: "MusicWebPlaygroundTests",
            dependencies: ["MusicWebPlayground"]
        ),
    ]
)
