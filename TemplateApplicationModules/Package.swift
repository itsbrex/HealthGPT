// swift-tools-version: 5.7

//
// This source file is part of the Stanford CardinalKit Template Application project
//
// SPDX-FileCopyrightText: 2023 Stanford University
//
// SPDX-License-Identifier: MIT
//

import PackageDescription


let package = Package(
    name: "TemplateModules",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "TemplateContacts", targets: ["TemplateContacts"]),
        .library(name: "TemplateMockDataStorageProvider", targets: ["TemplateMockDataStorageProvider"]),
        .library(name: "TemplateOnboardingFlow", targets: ["TemplateOnboardingFlow"]),
        .library(name: "TemplateSchedule", targets: ["TemplateSchedule"]),
        .library(name: "TemplateSharedContext", targets: ["TemplateSharedContext"])
    ],
    dependencies: [
        .package(url: "https://github.com/StanfordBDHG/CardinalKit.git", branch: "main")
    ],
    targets: [
        .target(
            name: "TemplateContacts",
            dependencies: [
                .target(name: "TemplateSharedContext"),
                .product(name: "Contact", package: "CardinalKit")
            ]
        ),
        .target(
            name: "TemplateMockDataStorageProvider",
            dependencies: [
                .target(name: "TemplateSharedContext"),
                .product(name: "CardinalKit", package: "CardinalKit"),
                .product(name: "FHIR", package: "CardinalKit")
            ]
        ),
        .target(
            name: "TemplateOnboardingFlow",
            dependencies: [
                .target(name: "TemplateSharedContext"),
                .product(name: "FHIR", package: "CardinalKit"),
                .product(name: "HealthKitDataSource", package: "CardinalKit"),
                .product(name: "Onboarding", package: "CardinalKit")
            ]
        ),
        .target(
            name: "TemplateSchedule",
            dependencies: [
                .target(name: "TemplateSharedContext"),
                .product(name: "FHIR", package: "CardinalKit"),
                .product(name: "Questionnaires", package: "CardinalKit"),
                .product(name: "Scheduler", package: "CardinalKit")
            ]
        ),
        .target(
            name: "TemplateSharedContext",
            dependencies: []
        ),
    ]
)