// swift-tools-version:5.4.0
import PackageDescription

let package = Package(
    name: "InfiniteCollectionView",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(
            name: "InfiniteCollectionView",
            targets: ["InfiniteCollectionView"]
        )
    ],
    targets: [
        .target(name: "InfiniteCollectionView", path: "Sources"),
    ]
)
