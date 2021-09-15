// swift-tools-version:5.4.0
import PackageDescription

let package = Package(
    name: "InfiniteCollectionView",
    products: [
        .library(
            name: "InfiniteCollectionView",
            targets: ["InfiniteCollectionView"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pavelaron/InfiniteCollectionView", from: "1.3.4"),
    ],
    targets: []
)
