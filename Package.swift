// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XlsxReaderWriter",
    platforms: [
       .iOS(.v12),
    ],
    products: [
        .library(
            name: "XlsxReaderWriter",
            targets: ["XlsxReaderWriter"]),
    ],
        dependencies: [
        .package(url: "https://github.com/ZipArchive/ZipArchive", from: "2.4.2"),
    ],
    targets: [
        .target(
            name: "XlsxReaderWriter",
            dependencies: [
                .product(name: "ZipArchive", package: "ZipArchive"),
            ],
            publicHeadersPath: "XlsxReaderWriter",
            cSettings: [
                .headerSearchPath("XlsxReaderWriter"),
                .headerSearchPath("."),
              ]
            )
    ]
)
