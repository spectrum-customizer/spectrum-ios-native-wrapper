// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "SpectrumCustomizer",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "SpectrumCustomizer",
            targets: ["SpectrumCustomizer"]
        )
    ],
    targets: [
        .target(
            name: "SpectrumCustomizer",
            path: "SpectrumCustomizer/SpectrumCustomizer",
            exclude: [
                "Bundler+Extensions.swift"
            ],
            resources: [
                .copy("SpectrumCustomizerView.xib"),
                .copy("web/index.html")
            ]
        )
    ]
)
