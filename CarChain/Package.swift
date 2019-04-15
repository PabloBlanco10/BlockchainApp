// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CarChain",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "CarChain",
            targets: ["CarChain"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Boilertalk/Web3.swift.git", from: "0.3.0")
    ],
    targets: [
        .target(
            name: "CarChain",
            dependencies: ["Web3", "Web3PromiseKit", "Web3ContractABI"]),
        .testTarget(
            name: "CarChainTests",
            dependencies: ["CarChain"])
    ]
)
