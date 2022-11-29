// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Accumulation",
    platforms: [.iOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Accumulation",
            targets: ["Accumulation"]),
        .library(name: "Extension",
                 targets: ["AccumulationExtension"]),
        .library(name: "Helper", targets: ["AccumulationHelper"]),
        .library(name: "Authorizations", targets: ["AuthorizationsCore",
                                                   "AuthorizationsAV",
                                                   "AuthorizationsPH"]),
        .library(name: "Capture", targets: ["Capture"])

    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "git@gitee.com:bear-bro/Alamofire.git", .upToNextMajor(from: "5.6.1")),
        .package(url: "git@gitee.com:bear-bro/Promises.git", from: "2.1.0"),
        .package(url: "git@gitee.com:bear-bro/Nimble.git", .upToNextMajor(from: "9.0.0")),
        .package(url: "git@gitee.com:bear-bro/Quick.git", .upToNextMajor(from: "4.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Accumulation",
            dependencies: [
                "AccumulationExtension"
            ]),
        .target(name: "AccumulationExtension",
                dependencies: []),
        .target(name: "AccumulationHelper",
                dependencies: [
                    .product(name: "Alamofire", package: "Alamofire"),
                    .product(name: "Promises", package: "Promises")
                ]),
        .target(name: "AuthorizationsAV", dependencies: ["AuthorizationsCore"]),
        .target(name: "AuthorizationsPH", dependencies: ["AuthorizationsCore"]),
        .target(name: "AuthorizationsCore", dependencies: []),
        .target(name: "Capture", dependencies: ["AuthorizationsPH"])
    ]
)
