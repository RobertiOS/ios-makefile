//
// (c) 2025 Roberto Corrales, All rights reserved.
//
//
//

import ProjectDescription

let project = Project(
    name: "ios-makefile",
    targets: [
        .target(
            name: "ios-makefile",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.ios-makefile",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": ""
                    ]
                ]
            ),
            sources: ["ios-makefile/Sources/**"],
            resources: ["ios-makefile/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "ios-makefileTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.ios-makefileTests",
            infoPlist: .default,
            sources: ["ios-makefile/Tests/**"],
            resources: [],
            dependencies: [.target(name: "ios-makefile")]
        )
    ]
)
