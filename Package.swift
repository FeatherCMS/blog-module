// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "blog-module",
    platforms: [
       .macOS(.v12)
    ],
    products: [
        .library(name: "BlogModule", targets: ["BlogModule"]),
    ],
    dependencies: [
//		.package(path: "../feather-core"),
//		.package(path: "../blog-objects"),
//		.package(path: "../web-module"),
        .package(url: "https://github.com/Rando-Coderissian/feather-core", .branch("test-refactored-modules")),
        .package(url: "https://github.com/Rando-Coderissian/blog-objects", .branch("test-refactor-modules")),
        .package(url: "https://github.com/Rando-Coderissian/web-module", .branch("test-refactor-modules")),

//        .package(url: "https://github.com/feathercms/feather-core", .branch("dev")),
//        .package(url: "https://github.com/feathercms/blog-objects", .branch("main")),
//        .package(url: "https://github.com/feathercms/web-module", .branch("main")),
    ],
    targets: [
        .target(name: "BlogModule", dependencies: [
            .product(name: "FeatherCore", package: "feather-core"),
            .product(name: "BlogObjects", package: "blog-objects"),
            .product(name: "WebModule", package: "web-module"),
        ],
        resources: [
            .copy("Bundle"),
        ]),
    ]
)
