//// swift-tools-version:5.6
//// The swift-tools-version declares the minimum version of Swift required to
//// build this package.
//
//// Copyright 2020 Google LLC
////
//// Licensed under the Apache License, Version 2.0 (the "License");
//// you may not use this file except in compliance with the License.
//// You may obtain a copy of the License at
////
////      http://www.apache.org/licenses/LICENSE-2.0
////
//// Unless required by applicable law or agreed to in writing, software
//// distributed under the License is distributed on an "AS IS" BASIS,
//// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//// See the License for the specific language governing permissions and
//// limitations under the License.
//
//import class Foundation.ProcessInfo
//import PackageDescription
//
//let firebaseVersion = "10.20.0"
//
//let package = Package(
//  name: "Firebase",
//  platforms: [.iOS(.v11), .macCatalyst(.v13), .macOS(.v10_13), .tvOS(.v12), .watchOS(.v7)],
//  products: [
//    .library(
//      name: "FirebaseAnalytics",
//      targets: ["FirebaseAnalyticsTarget"]
//    ),
//    .library(
//      name: "FirebaseAuth",
//      targets: ["FirebaseAuth"]
//    ),
//    .library(
//      name: "FirebaseRemoteConfig",
//      targets: ["FirebaseRemoteConfig"]
//    ),
//    .library(
//      name: "FirebaseRemoteConfigSwift",
//      targets: ["FirebaseRemoteConfigSwift"]
//    ),
//    .library(
//      name: "FirebaseStorage",
//      targets: ["FirebaseStorage"]
//    ),
//  ],
//  dependencies: [
//    .package(
//      url: "https://github.com/google/promises.git",
//      "2.1.0" ..< "3.0.0"
//    ),
//    .package(
//      url: "https://github.com/apple/swift-protobuf.git",
//      "1.19.0" ..< "2.0.0"
//    ),
//    googleAppMeasurementDependency(),
//    .package(
//      url: "https://github.com/google/GoogleDataTransport.git",
//      "9.3.0" ..< "10.0.0"
//    ),
//    .package(
//      url: "https://github.com/google/GoogleUtilities.git",
//      "7.12.1" ..< "8.0.0"
//    ),
//    .package(
//      url: "https://github.com/google/gtm-session-fetcher.git",
//      "2.1.0" ..< "4.0.0"
//    ),
//    .package(
//      url: "https://github.com/firebase/nanopb.git",
//      "2.30909.0" ..< "2.30910.0"
//    ),
//    abseilDependency(),
//    grpcDependency(),
//    .package(
//      url: "https://github.com/erikdoe/ocmock.git",
//      revision: "c5eeaa6dde7c308a5ce48ae4d4530462dd3a1110"
//    ),
//    .package(
//      url: "https://github.com/firebase/leveldb.git",
//      "1.22.2" ..< "1.23.0"
//    ),
//    .package(
//      url: "https://github.com/SlaunchaMan/GCDWebServer.git",
//      revision: "935e2736044e71e5341663c3cc9a335ba6867a2b"
//    ),
//    .package(
//      url: "https://github.com/google/interop-ios-for-google-sdks.git",
//      "100.0.0" ..< "101.0.0"
//    ),
//    .package(url: "https://github.com/google/app-check.git", "10.18.0" ..< "11.0.0"),
//  ],
//  targets: [
//    .target(
//      name: "Firebase",
//      path: "CoreOnly/Sources",
//      publicHeadersPath: "./"
//    ),
//    .target(
//      name: "FirebaseCore",
//      dependencies: [
//        "Firebase",
//        "FirebaseCoreInternal",
//        .product(name: "GULEnvironment", package: "GoogleUtilities"),
//        .product(name: "GULLogger", package: "GoogleUtilities"),
//      ],
//      path: "FirebaseCore/Sources",
//      publicHeadersPath: "Public",
//      cSettings: [
//        .headerSearchPath("../.."),
//        .define("Firebase_VERSION", to: firebaseVersion),
//        // TODO: - Add support for cflags cSetting so that we can set the -fno-autolink option
//      ],
//      linkerSettings: [
//        .linkedFramework("UIKit", .when(platforms: [.iOS, .macCatalyst, .tvOS])),
//        .linkedFramework("AppKit", .when(platforms: [.macOS])),
//      ]
//    ),
//
//    // MARK: - Firebase Core Extension
//
//    // Extension of FirebaseCore for consuming by Swift product SDKs.
//    // When depending on `FirebaseCoreExtension`, also depend on `FirebaseCore`
//    // to avoid potential linker issues.
//    .target(
//      name: "FirebaseCoreExtension",
//      path: "FirebaseCore/Extension",
//      publicHeadersPath: ".",
//      cSettings: [
//        .headerSearchPath("../../"),
//      ]
//    ),
//
//    // MARK: - Firebase Core Internal
//
//    // Shared collection of APIs for internal FirebaseCore usage.
//    .target(
//      name: "FirebaseCoreInternal",
//      dependencies: [
//        .product(name: "GULNSData", package: "GoogleUtilities"),
//      ],
//      path: "FirebaseCore/Internal/Sources"
//    ),
//
//    .target(
//      name: "FirebaseABTesting",
//      dependencies: ["FirebaseCore"],
//      path: "FirebaseABTesting/Sources",
//      publicHeadersPath: "Public",
//      cSettings: [
//        .headerSearchPath("../../"),
//      ]
//    ),
//
//    .target(
//      name: "FirebaseAnalyticsTarget",
//      dependencies: [.target(name: "FirebaseAnalyticsWrapper",
//                             condition: .when(platforms: [.iOS, .macCatalyst, .macOS, .tvOS]))],
//      path: "SwiftPM-PlatformExclude/FirebaseAnalyticsWrap"
//    ),
//
//    .target(
//      name: "FirebaseAnalyticsWrapper",
//      dependencies: [
//        .target(
//          name: "FirebaseAnalytics",
//          condition: .when(platforms: [.iOS, .macCatalyst, .macOS, .tvOS])
//        ),
//        .product(name: "GoogleAppMeasurement",
//                 package: "GoogleAppMeasurement",
//                 condition: .when(platforms: [.iOS, .macCatalyst, .macOS, .tvOS])),
//        "FirebaseCore",
//        "FirebaseInstallations",
//        .product(name: "GULAppDelegateSwizzler", package: "GoogleUtilities"),
//        .product(name: "GULMethodSwizzler", package: "GoogleUtilities"),
//        .product(name: "GULNSData", package: "GoogleUtilities"),
//        .product(name: "GULNetwork", package: "GoogleUtilities"),
//        .product(name: "nanopb", package: "nanopb"),
//      ],
//      path: "FirebaseAnalyticsWrapper",
//      linkerSettings: [
//        .linkedLibrary("sqlite3"),
//        .linkedLibrary("c++"),
//        .linkedLibrary("z"),
//        .linkedFramework("StoreKit"),
//      ]
//    ),
//    .binaryTarget(
//      name: "FirebaseAnalytics",
//      url: "https://dl.google.com/firebase/ios/swiftpm/10.20.0/FirebaseAnalytics.zip",
//      checksum: "169e9983be26e31bff373ea3ae5b56559a49f6bf14986f8813be5af03c00b251"
//    ),
//    .target(
//      name: "FirebaseAnalyticsSwiftTarget",
//      dependencies: [.target(name: "FirebaseAnalyticsSwift",
//                             condition: .when(platforms: [.iOS, .macCatalyst, .macOS, .tvOS]))],
//      path: "SwiftPM-PlatformExclude/FirebaseAnalyticsSwiftWrap"
//    ),
//    .target(
//      name: "FirebaseAnalyticsSwift",
//      dependencies: ["FirebaseAnalyticsWrapper"],
//      path: "FirebaseAnalyticsSwift/Sources"
//    ),
//
//    .target(
//      name: "FirebaseAnalyticsWithoutAdIdSupportTarget",
//      dependencies: [.target(name: "FirebaseAnalyticsWithoutAdIdSupportWrapper",
//                             condition: .when(platforms: [.iOS, .macCatalyst, .macOS, .tvOS]))],
//      path: "SwiftPM-PlatformExclude/FirebaseAnalyticsWithoutAdIdSupportWrap"
//    ),
//    .target(
//      name: "FirebaseAnalyticsWithoutAdIdSupportWrapper",
//      dependencies: [
//        .target(
//          name: "FirebaseAnalytics",
//          condition: .when(platforms: [.iOS, .macCatalyst, .macOS, .tvOS])
//        ),
//        .product(name: "GoogleAppMeasurementWithoutAdIdSupport",
//                 package: "GoogleAppMeasurement",
//                 condition: .when(platforms: [.iOS, .macCatalyst, .macOS, .tvOS])),
//        "FirebaseCore",
//        "FirebaseInstallations",
//        .product(name: "GULAppDelegateSwizzler", package: "GoogleUtilities"),
//        .product(name: "GULMethodSwizzler", package: "GoogleUtilities"),
//        .product(name: "GULNSData", package: "GoogleUtilities"),
//        .product(name: "GULNetwork", package: "GoogleUtilities"),
//        .product(name: "nanopb", package: "nanopb"),
//      ],
//      path: "FirebaseAnalyticsWithoutAdIdSupportWrapper",
//      linkerSettings: [
//        .linkedLibrary("sqlite3"),
//        .linkedLibrary("c++"),
//        .linkedLibrary("z"),
//        .linkedFramework("StoreKit"),
//      ]
//    ),
//
//    .target(
//      name: "FirebaseAnalyticsOnDeviceConversionTarget",
//      dependencies: [
//        .product(name: "GoogleAppMeasurementOnDeviceConversion",
//                 package: "GoogleAppMeasurement",
//                 condition: .when(platforms: [.iOS])),
//      ],
//      path: "FirebaseAnalyticsOnDeviceConversionWrapper",
//      linkerSettings: [
//        .linkedLibrary("c++"),
//      ]
//    ),
//
//    .target(
//      name: "FirebaseAppDistributionTarget",
//      dependencies: [.target(name: "FirebaseAppDistribution",
//                             condition: .when(platforms: [.iOS]))],
//      path: "SwiftPM-PlatformExclude/FirebaseAppDistributionWrap"
//    ),
//    .target(
//      name: "FirebaseAppDistribution",
//      dependencies: [
//        "FirebaseCore",
//        "FirebaseInstallations",
//        .product(name: "GULAppDelegateSwizzler", package: "GoogleUtilities"),
//        .product(name: "GULUserDefaults", package: "GoogleUtilities"),
//      ],
//      path: "FirebaseAppDistribution/Sources",
//      publicHeadersPath: "Public",
//      cSettings: [
//        .headerSearchPath("../../"),
//      ]
//    ),
//
//    .target(
//      name: "FirebaseAuth",
//      dependencies: [
//        "FirebaseAppCheckInterop",
//        "FirebaseCore",
//        .product(name: "GULAppDelegateSwizzler", package: "GoogleUtilities"),
//        .product(name: "GULEnvironment", package: "GoogleUtilities"),
//        .product(name: "GTMSessionFetcherCore", package: "gtm-session-fetcher"),
//        .product(name: "RecaptchaInterop", package: "interop-ios-for-google-sdks"),
//      ],
//      path: "FirebaseAuth/Sources",
//      publicHeadersPath: "Public",
//      cSettings: [
//        .headerSearchPath("../../"),
//      ],
//      linkerSettings: [
//        .linkedFramework("Security"),
//        .linkedFramework("SafariServices", .when(platforms: [.iOS])),
//      ]
//    ),
//    // Internal headers only for consuming from Swift.
//    .target(
//      name: "FirebaseAuthInterop",
//      path: "FirebaseAuth/Interop",
//      exclude: [
//        "CMakeLists.txt",
//      ],
//      publicHeadersPath: ".",
//      cSettings: [
//        .headerSearchPath("../../"),
//      ]
//    ),
//    .target(
//      name: "FirebaseAuthCombineSwift",
//      dependencies: ["FirebaseAuth"],
//      path: "FirebaseCombineSwift/Sources/Auth"
//    ),
//    .target(
//      name: "FirebaseFirestoreCombineSwift",
//      dependencies: [
//        "FirebaseFirestoreTarget",
//        "FirebaseFirestoreSwift",
//      ],
//      path: "FirebaseCombineSwift/Sources/Firestore"
//    ),
//    .target(
//      name: "FirebaseStorageCombineSwift",
//      dependencies: [
//        "FirebaseStorage",
//      ],
//      path: "FirebaseCombineSwift/Sources/Storage"
//    ),
//    .target(
//      name: "FirebaseCrashlytics",
//      dependencies: ["FirebaseCore", "FirebaseInstallations", "FirebaseSessions",
//                     .product(name: "GoogleDataTransport", package: "GoogleDataTransport"),
//                     .product(name: "GULEnvironment", package: "GoogleUtilities"),
//                     .product(name: "FBLPromises", package: "Promises"),
//                     .product(name: "nanopb", package: "nanopb")],
//      path: "Crashlytics",
//      exclude: [
//        "run",
//        "CHANGELOG.md",
//        "LICENSE",
//        "README.md",
//        "ProtoSupport/",
//        "UnitTests/",
//        "generate_project.sh",
//        "upload-symbols",
//        "CrashlyticsInputFiles.xcfilelist",
//        "third_party/libunwind/LICENSE",
//      ],
//      sources: [
//        "Crashlytics/",
//        "Protogen/",
//        "Shared/",
//        "third_party/libunwind/dwarf.h",
//      ],
//      publicHeadersPath: "Crashlytics/Public",
//      cSettings: [
//        .headerSearchPath(".."),
//        .define("DISPLAY_VERSION", to: firebaseVersion),
//        .define("CLS_SDK_NAME", to: "Crashlytics iOS SDK", .when(platforms: [.iOS])),
//        .define(
//          "CLS_SDK_NAME",
//          to: "Crashlytics macOS SDK",
//          .when(platforms: [.macOS, .macCatalyst])
//        ),
//        .define("CLS_SDK_NAME", to: "Crashlytics tvOS SDK", .when(platforms: [.tvOS])),
//        .define("CLS_SDK_NAME", to: "Crashlytics watchOS SDK", .when(platforms: [.watchOS])),
//        .define("PB_FIELD_32BIT", to: "1"),
//        .define("PB_NO_PACKED_STRUCTS", to: "1"),
//        .define("PB_ENABLE_MALLOC", to: "1"),
//      ],
//      linkerSettings: [
//        .linkedFramework("Security"),
//        .linkedFramework("SystemConfiguration", .when(platforms: [.iOS, .macOS, .tvOS])),
//      ]
//    ),
//    .target(
//      name: "FirebaseDatabaseInternal",
//      dependencies: [
//        "FirebaseAppCheckInterop",
//        "FirebaseCore",
//        "leveldb",
//      ],
//      path: "FirebaseDatabase/Sources",
//      exclude: [
//        "third_party/Wrap-leveldb/LICENSE",
//        "third_party/SocketRocket/LICENSE",
//        "third_party/FImmutableSortedDictionary/LICENSE",
//        "third_party/SocketRocket/aa2297808c225710e267afece4439c256f6efdb3",
//      ],
//      publicHeadersPath: "Public",
//      cSettings: [
//        .headerSearchPath("../../"),
//      ],
//      linkerSettings: [
//        .linkedFramework("CFNetwork"),
//        .linkedFramework("Security"),
//        .linkedFramework("SystemConfiguration", .when(platforms: [.iOS, .macOS, .tvOS])),
//        .linkedFramework("WatchKit", .when(platforms: [.watchOS])),
//      ]
//    ),
//    .target(
//      name: "FirebaseDatabase",
//      dependencies: ["FirebaseDatabaseInternal", "FirebaseSharedSwift"],
//      path: "FirebaseDatabase/Swift/Sources"
//    ),
//    .target(
//      name: "FirebaseDatabaseSwift",
//      dependencies: ["FirebaseDatabase"],
//      path: "FirebaseDatabaseSwift/Sources"
//    ),
//    .target(
//      name: "FirebaseSharedSwift",
//      path: "FirebaseSharedSwift/Sources",
//      exclude: [
//        "third_party/FirebaseDataEncoder/LICENSE",
//        "third_party/FirebaseDataEncoder/METADATA",
//      ]
//    ),
//    .target(
//      name: "FirebaseDynamicLinksTarget",
//      dependencies: [.target(name: "FirebaseDynamicLinks",
//                             condition: .when(platforms: [.iOS]))],
//      path: "SwiftPM-PlatformExclude/FirebaseDynamicLinksWrap"
//    ),
//
//    .target(
//      name: "FirebaseDynamicLinks",
//      dependencies: ["FirebaseCore"],
//      path: "FirebaseDynamicLinks/Sources",
//      publicHeadersPath: "Public",
//      cSettings: [
//        .headerSearchPath("../../"),
//        .define("FIRDynamicLinks3P", to: "1"),
//        .define("GIN_SCION_LOGGING", to: "1"),
//      ],
//      linkerSettings: [
//        .linkedFramework("QuartzCore"),
//      ]
//    ),
//    firestoreWrapperTarget(),
//    .target(
//      name: "FirebaseFirestoreSwiftTarget",
//      dependencies: [.target(name: "FirebaseFirestoreSwift",
//                             condition: .when(platforms: [.iOS, .macCatalyst, .tvOS, .macOS,
//                                                          .firebaseVisionOS]))],
//      path: "SwiftPM-PlatformExclude/FirebaseFirestoreSwiftWrap"
//    ),
//
//    .target(
//      name: "FirebaseFirestoreSwift",
//      dependencies: [
//        "FirebaseFirestoreTarget",
//      ],
//      path: "FirebaseFirestoreSwift/Sources"
//    ),
//
//    // MARK: - Firebase Functions
//
//    .target(
//      name: "FirebaseFunctions",
//      dependencies: [
//        "FirebaseAppCheckInterop",
//        "FirebaseAuthInterop",
//        "FirebaseCore",
//        "FirebaseCoreExtension",
//        "FirebaseMessagingInterop",
//        "FirebaseSharedSwift",
//        .product(name: "GTMSessionFetcherCore", package: "gtm-session-fetcher"),
//      ],
//      path: "FirebaseFunctions/Sources"
//    ),
//    .target(
//      name: "FirebaseFunctionsCombineSwift",
//      dependencies: ["FirebaseFunctions"],
//      path: "FirebaseCombineSwift/Sources/Functions"
//    ),
//
//    // MARK: - Firebase In App Messaging
//
//    .target(
//      name: "FirebaseInAppMessagingTarget",
//      dependencies: [
//        .target(name: "FirebaseInAppMessaging", condition: .when(platforms: [.iOS, .tvOS])),
//      ],
//      path: "SwiftPM-PlatformExclude/FirebaseInAppMessagingWrap"
//    ),
//
//    .target(
//      name: "FirebaseInAppMessagingInternal",
//      dependencies: [
//        "FirebaseCore",
//        "FirebaseInstallations",
//        "FirebaseABTesting",
//        .product(name: "GULEnvironment", package: "GoogleUtilities"),
//        .product(name: "nanopb", package: "nanopb"),
//        .target(name: "FirebaseInAppMessaging_iOS", condition: .when(platforms: [.iOS])),
//      ],
//      path: "FirebaseInAppMessaging/Sources",
//      exclude: [
//        "DefaultUI/CHANGELOG.md",
//        "DefaultUI/README.md",
//      ],
//      publicHeadersPath: "Public",
//      cSettings: [
//        .headerSearchPath("../../"),
//        .define("PB_FIELD_32BIT", to: "1"),
//        .define("PB_NO_PACKED_STRUCTS", to: "1"),
//        .define("PB_ENABLE_MALLOC", to: "1"),
//      ]
//    ),
//
//    .target(
//      name: "FirebaseInAppMessaging_iOS",
//      path: "FirebaseInAppMessaging/iOS",
//      resources: [.process("Resources")]
//    ),
//
//    .target(
//      name: "FirebaseInAppMessaging",
//      dependencies: ["FirebaseInAppMessagingInternal"],
//      path: "FirebaseInAppMessaging/Swift/Source"
//    ),
//
//    .target(
//      name: "FirebaseInAppMessagingSwift",
//      dependencies: ["FirebaseInAppMessaging"],
//      path: "FirebaseInAppMessagingSwift/Sources"
//    ),
//
//    .target(
//      name: "FirebaseInstallations",
//      dependencies: [
//        "FirebaseCore",
//        .product(name: "FBLPromises", package: "Promises"),
//        .product(name: "GULEnvironment", package: "GoogleUtilities"),
//        .product(name: "GULUserDefaults", package: "GoogleUtilities"),
//      ],
//      path: "FirebaseInstallations/Source/Library",
//      publicHeadersPath: "Public",
//      cSettings: [
//        .headerSearchPath("../../../"),
//      ],
//      linkerSettings: [
//        .linkedFramework("Security"),
//      ]
//    ),
//
//    .target(
//      name: "FirebaseMLModelDownloader",
//      dependencies: [
//        "FirebaseCore",
//        "FirebaseInstallations",
//        .product(name: "GoogleDataTransport", package: "GoogleDataTransport"),
//        .product(name: "GULLogger", package: "GoogleUtilities"),
//        .product(name: "SwiftProtobuf", package: "swift-protobuf"),
//      ],
//      path: "FirebaseMLModelDownloader/Sources",
//      exclude: [
//        "proto/firebase_ml_log_sdk.proto",
//      ],
//      cSettings: [
//        .define("FIRMLModelDownloader_VERSION", to: firebaseVersion),
//      ]
//    ),
//
//    .target(
//      name: "FirebaseMessaging",
//      dependencies: [
//        "FirebaseCore",
//        "FirebaseInstallations",
//        .product(name: "GULAppDelegateSwizzler", package: "GoogleUtilities"),
//        .product(name: "GULEnvironment", package: "GoogleUtilities"),
//        .product(name: "GULReachability", package: "GoogleUtilities"),
//        .product(name: "GULUserDefaults", package: "GoogleUtilities"),
//        .product(name: "GoogleDataTransport", package: "GoogleDataTransport"),
//        .product(name: "nanopb", package: "nanopb"),
//      ],
//      path: "FirebaseMessaging/Sources",
//      publicHeadersPath: "Public",
//      cSettings: [
//        .headerSearchPath("../../"),
//        .define("PB_FIELD_32BIT", to: "1"),
//        .define("PB_NO_PACKED_STRUCTS", to: "1"),
//        .define("PB_ENABLE_MALLOC", to: "1"),
//      ],
//      linkerSettings: [
//        .linkedFramework("SystemConfiguration", .when(platforms: [.iOS, .macOS, .tvOS])),
//      ]
//    ),
//    // Internal headers only for consuming from Swift.
//    .target(
//      name: "FirebaseMessagingInterop",
//      path: "FirebaseMessaging/Interop",
//      publicHeadersPath: ".",
//      cSettings: [
//        .headerSearchPath("../../"),
//      ]
//    ),
//    .target(
//      name: "FirebasePerformanceTarget",
//      dependencies: [.target(name: "FirebasePerformance",
//                             condition: .when(platforms: [.iOS, .tvOS, .firebaseVisionOS]))],
//      path: "SwiftPM-PlatformExclude/FirebasePerformanceWrap"
//    ),
//    .target(
//      name: "FirebasePerformance",
//      dependencies: [
//        "FirebaseCore",
//        "FirebaseInstallations",
//        // Performance depends on the Obj-C target of FirebaseRemoteConfig to
//        // avoid including Swift code from the `FirebaseRemoteConfig` target
//        // that is unneeded.
//        "FirebaseRemoteConfigInternal",
//        "FirebaseSessions",
//        .product(name: "GoogleDataTransport", package: "GoogleDataTransport"),
//        .product(name: "GULEnvironment", package: "GoogleUtilities"),
//        .product(name: "GULISASwizzler", package: "GoogleUtilities"),
//        .product(name: "GULMethodSwizzler", package: "GoogleUtilities"),
//        .product(name: "GULUserDefaults", package: "GoogleUtilities"),
//        .product(name: "nanopb", package: "nanopb"),
//      ],
//      path: "FirebasePerformance/Sources",
//      publicHeadersPath: "Public",
//      cSettings: [
//        .headerSearchPath("../../"),
//        .define("PB_FIELD_32BIT", to: "1"),
//        .define("PB_NO_PACKED_STRUCTS", to: "1"),
//        .define("PB_ENABLE_MALLOC", to: "1"),
//        .define("FIRPerformance_LIB_VERSION", to: firebaseVersion),
//      ],
//      linkerSettings: [
//        .linkedFramework("SystemConfiguration", .when(platforms: [.iOS, .tvOS])),
//        .linkedFramework("MobileCoreServices", .when(platforms: [.iOS, .tvOS])),
//        .linkedFramework("QuartzCore", .when(platforms: [.iOS, .tvOS])),
//      ]
//    ),
//    .target(
//      name: "SharedTestUtilities",
//      dependencies: ["FirebaseCore",
//                     "FirebaseAppCheckInterop",
//                     "FirebaseAuthInterop",
//                     "FirebaseMessagingInterop",
//                     "GoogleDataTransport",
//                     .product(name: "OCMock", package: "ocmock")],
//      path: "SharedTestUtilities",
//      publicHeadersPath: "./",
//      cSettings: [
//        .headerSearchPath("../"),
//      ]
//    ),
//
//    // MARK: - Firebase Remote Config
//
//    .target(
//      name: "FirebaseRemoteConfigInternal",
//      dependencies: [
//        "FirebaseCore",
//        "FirebaseABTesting",
//        "FirebaseInstallations",
//        .product(name: "GULNSData", package: "GoogleUtilities"),
//      ],
//      path: "FirebaseRemoteConfig/Sources",
//      publicHeadersPath: "Public",
//      cSettings: [
//        .headerSearchPath("../../"),
//      ]
//    ),
//    .target(
//      name: "FirebaseRemoteConfig",
//      dependencies: [
//        "FirebaseRemoteConfigInternal",
//        "FirebaseSharedSwift",
//      ],
//      path: "FirebaseRemoteConfig/Swift"
//    ),
//    .target(
//      name: "FirebaseRemoteConfigSwift",
//      dependencies: [
//        "FirebaseRemoteConfig",
//      ],
//      path: "FirebaseRemoteConfigSwift/Sources"
//    ),
//    .target(
//      name: "RemoteConfigFakeConsoleObjC",
//      dependencies: [.product(name: "OCMock", package: "ocmock")],
//      path: "FirebaseRemoteConfigSwift/Tests/ObjC",
//      publicHeadersPath: ".",
//      cSettings: [
//        .headerSearchPath("../../../"),
//      ]
//    ),
//
//    // MARK: - Firebase Sessions
//
//    .target(
//      name: "FirebaseSessions",
//      dependencies: [
//        "FirebaseCore",
//        "FirebaseInstallations",
//        "FirebaseCoreExtension",
//        "FirebaseSessionsObjC",
//        .product(name: "Promises", package: "Promises"),
//        .product(name: "GoogleDataTransport", package: "GoogleDataTransport"),
//        .product(name: "GULEnvironment", package: "GoogleUtilities"),
//      ],
//      path: "FirebaseSessions/Sources",
//      cSettings: [
//        .headerSearchPath(".."),
//        .define("DISPLAY_VERSION", to: firebaseVersion),
//        .define("PB_FIELD_32BIT", to: "1"),
//        .define("PB_NO_PACKED_STRUCTS", to: "1"),
//        .define("PB_ENABLE_MALLOC", to: "1"),
//      ],
//      linkerSettings: [
//        .linkedFramework("Security"),
//        .linkedFramework(
//          "SystemConfiguration",
//          .when(platforms: [.iOS, .macCatalyst, .macOS, .tvOS])
//        ),
//      ]
//    ),
//    // The Sessions SDK is Swift-first with Objective-C code to support
//    // nanopb. Because Swift Package Manager doesn't support mixed
//    // language targets, the ObjC code has been extracted out into
//    // a separate target.
//    .target(
//      name: "FirebaseSessionsObjC",
//      dependencies: [
//        .product(name: "GULEnvironment", package: "GoogleUtilities"),
//        .product(name: "nanopb", package: "nanopb"),
//      ],
//      path: "FirebaseSessions",
//      exclude: [
//        "README.md",
//        "Sources/",
//        "Tests/",
//        "ProtoSupport/",
//        "generate_project.sh",
//        "generate_protos.sh",
//        "generate_testapp.sh",
//      ],
//      publicHeadersPath: "SourcesObjC",
//      cSettings: [
//        .headerSearchPath(".."),
//        .define("DISPLAY_VERSION", to: firebaseVersion),
//        .define("PB_FIELD_32BIT", to: "1"),
//        .define("PB_NO_PACKED_STRUCTS", to: "1"),
//        .define("PB_ENABLE_MALLOC", to: "1"),
//      ],
//      linkerSettings: [
//        .linkedFramework("Security"),
//        .linkedFramework(
//          "SystemConfiguration",
//          .when(platforms: [.iOS, .macCatalyst, .macOS, .tvOS])
//        ),
//      ]
//    ),
//    .testTarget(
//      name: "FirebaseSessionsUnit",
//      dependencies: ["FirebaseSessions"],
//      path: "FirebaseSessions/Tests/Unit"
//    ),
//
//    // MARK: - Firebase Storage
//
//    .target(
//      name: "FirebaseStorage",
//      dependencies: [
//        "FirebaseAppCheckInterop",
//        "FirebaseAuthInterop",
//        "FirebaseCore",
//        "FirebaseCoreExtension",
//        .product(name: "GTMSessionFetcherCore", package: "gtm-session-fetcher"),
//      ],
//      path: "FirebaseStorage/Sources"
//    ),
//
//    // MARK: - Firebase App Check
//
//    .target(name: "FirebaseAppCheck",
//            dependencies: [
//              "FirebaseAppCheckInterop",
//              "FirebaseCore",
//              .product(name: "AppCheckCore", package: "app-check"),
//              .product(name: "FBLPromises", package: "Promises"),
//              .product(name: "GULEnvironment", package: "GoogleUtilities"),
//            ],
//            path: "FirebaseAppCheck/Sources",
//            publicHeadersPath: "Public",
//            cSettings: [
//              .headerSearchPath("../.."),
//            ],
//            linkerSettings: [
//              .linkedFramework(
//                "DeviceCheck",
//                .when(platforms: [.iOS, .macCatalyst, .macOS, .tvOS])
//              ),
//            ]),
//    // Internal headers only for consuming from Swift.
//    .target(
//      name: "FirebaseAppCheckInterop",
//      path: "FirebaseAppCheck/Interop",
//      exclude: [
//        "CMakeLists.txt",
//      ],
//      publicHeadersPath: "Public",
//      cSettings: [
//        .headerSearchPath("../../"),
//      ]
//    ),
//
//    // MARK: Testing support
//
//    .target(
//      name: "FirebaseFirestoreTestingSupport",
//      dependencies: ["FirebaseFirestoreTarget"],
//      path: "FirebaseTestingSupport/Firestore/Sources",
//      publicHeadersPath: "./",
//      cSettings: [
//        .headerSearchPath("../../.."),
//        .headerSearchPath("../../../Firestore/Source/Public/FirebaseFirestore"),
//      ]
//    ),
//  ] + firestoreTargets(),
//  cLanguageStandard: .c99,
//  cxxLanguageStandard: CXXLanguageStandard.gnucxx14
//)
//
//// MARK: - Helper Functions
//
//func googleAppMeasurementDependency() -> Package.Dependency {
//  let appMeasurementURL = "https://github.com/google/GoogleAppMeasurement.git"
//
//  // Point SPM CI to the tip of main of https://github.com/google/GoogleAppMeasurement so that the
//  // release process can defer publishing the GoogleAppMeasurement tag until after testing.
//  if ProcessInfo.processInfo.environment["FIREBASECI_USE_LATEST_GOOGLEAPPMEASUREMENT"] != nil {
//    return .package(url: appMeasurementURL, branch: "main")
//  }
//
//  return .package(url: appMeasurementURL, exact: "10.20.0")
//}
//
//func abseilDependency() -> Package.Dependency {
//  let packageInfo: (url: String, range: Range<Version>)
//
//  // If building Firestore from source, abseil will need to be built as source
//  // as the headers in the binary version of abseil are unusable.
//  if ProcessInfo.processInfo.environment["FIREBASE_SOURCE_FIRESTORE"] != nil {
//    packageInfo = (
//      "https://github.com/firebase/abseil-cpp-SwiftPM.git",
//      "0.20220623.0" ..< "0.20220624.0"
//    )
//  } else {
//    packageInfo = (
//      "https://github.com/google/abseil-cpp-binary.git",
//      "1.2022062300.0" ..< "1.2022062400.0"
//    )
//  }
//
//  return .package(url: packageInfo.url, packageInfo.range)
//}
//
//func grpcDependency() -> Package.Dependency {
//  let packageInfo: (url: String, range: Range<Version>)
//
//  // If building Firestore from source, abseil will need to be built as source
//  // as the headers in the binary version of abseil are unusable.
//  if ProcessInfo.processInfo.environment["FIREBASE_SOURCE_FIRESTORE"] != nil {
//    packageInfo = ("https://github.com/grpc/grpc-ios.git", "1.49.1" ..< "1.50.0")
//  } else {
//    packageInfo = ("https://github.com/google/grpc-binary.git", "1.49.1" ..< "1.50.0")
//  }
//
//  return .package(url: packageInfo.url, packageInfo.range)
//}
//
//func firestoreWrapperTarget() -> Target {
//  if ProcessInfo.processInfo.environment["FIREBASE_SOURCE_FIRESTORE"] != nil {
//    return .target(
//      name: "FirebaseFirestoreTarget",
//      dependencies: [.target(name: "FirebaseFirestore",
//                             condition: .when(platforms: [.iOS, .tvOS, .macOS,
//                                                          .firebaseVisionOS]))],
//      path: "SwiftPM-PlatformExclude/FirebaseFirestoreWrap"
//    )
//  }
//
//  return .target(
//    name: "FirebaseFirestoreTarget",
//    dependencies: [.target(name: "FirebaseFirestore",
//                           condition: .when(platforms: [.iOS, .tvOS, .macOS, .macCatalyst]))],
//    path: "SwiftPM-PlatformExclude/FirebaseFirestoreWrap"
//  )
//}
//
//func firestoreTargets() -> [Target] {
//  if ProcessInfo.processInfo.environment["FIREBASE_SOURCE_FIRESTORE"] != nil {
//    return [
//      .target(
//        name: "FirebaseFirestoreInternalWrapper",
//        dependencies: [
//          "FirebaseAppCheckInterop",
//          "FirebaseCore",
//          "leveldb",
//          .product(name: "nanopb", package: "nanopb"),
//          .product(name: "abseil", package: "abseil-cpp-SwiftPM"),
//          .product(name: "gRPC-cpp", package: "grpc-ios"),
//        ],
//        path: "Firestore",
//        exclude: [
//          "CHANGELOG.md",
//          "CMakeLists.txt",
//          "Example/",
//          "LICENSE",
//          "Protos/CMakeLists.txt",
//          "Protos/Podfile",
//          "Protos/README.md",
//          "Protos/build_protos.py",
//          "Protos/cpp/",
//          "Protos/lib/",
//          "Protos/nanopb_cpp_generator.py",
//          "Protos/protos/",
//          "README.md",
//          "Source/CMakeLists.txt",
//          "Swift/",
//          "core/CMakeLists.txt",
//          "core/src/util/config_detected.h.in",
//          "core/test/",
//          "fuzzing/",
//          "test.sh",
//          // Swift PM doesn't recognize hpp files, so we're relying on search paths
//          // to find third_party/nlohmann_json/json.hpp.
//          "third_party/",
//
//          // Exclude alternate implementations for other platforms
//          "core/src/remote/connectivity_monitor_noop.cc",
//          "core/src/util/filesystem_win.cc",
//          "core/src/util/log_stdio.cc",
//          "core/src/util/secure_random_openssl.cc",
//        ],
//        sources: [
//          "Source/",
//          "Protos/nanopb/",
//          "core/include/",
//          "core/src",
//        ],
//        publicHeadersPath: "Source/Public",
//        cSettings: [
//          .headerSearchPath("../"),
//          .headerSearchPath("Source/Public/FirebaseFirestore"),
//          .headerSearchPath("Protos/nanopb"),
//          .define("PB_FIELD_32BIT", to: "1"),
//          .define("PB_NO_PACKED_STRUCTS", to: "1"),
//          .define("PB_ENABLE_MALLOC", to: "1"),
//          .define("FIRFirestore_VERSION", to: firebaseVersion),
//        ],
//        linkerSettings: [
//          .linkedFramework(
//            "SystemConfiguration",
//            .when(platforms: [.iOS, .macOS, .tvOS, .firebaseVisionOS])
//          ),
//          .linkedFramework("UIKit", .when(platforms: [.iOS, .tvOS, .firebaseVisionOS])),
//          .linkedLibrary("c++"),
//        ]
//      ),
//      .target(
//        name: "FirebaseFirestore",
//        dependencies: [
//          "FirebaseCore",
//          "FirebaseCoreExtension",
//          "FirebaseFirestoreInternalWrapper",
//          "FirebaseSharedSwift",
//        ],
//        path: "Firestore",
//        exclude: [
//          "CHANGELOG.md",
//          "CMakeLists.txt",
//          "Example/",
//          "LICENSE",
//          "Protos/",
//          "README.md",
//          "Source/",
//          "core/",
//          "fuzzing/",
//          "test.sh",
//          "Swift/CHANGELOG.md",
//          "Swift/Tests/",
//          "third_party/nlohmann_json",
//        ],
//        sources: [
//          "Swift/Source/",
//        ]
//      ),
//    ]
//  }
//
//  let firestoreInternalTarget: Target = {
//    if ProcessInfo.processInfo.environment["FIREBASECI_USE_LOCAL_FIRESTORE_ZIP"] != nil {
//      // This is set when running `scripts/check_firestore_symbols.sh`.
//      return .binaryTarget(
//        name: "FirebaseFirestoreInternal",
//        // The `xcframework` should be moved to the root of the repo.
//        path: "FirebaseFirestoreInternal.xcframework"
//      )
//    } else {
//      return .binaryTarget(
//        name: "FirebaseFirestoreInternal",
//        url: "https://dl.google.com/firebase/ios/bin/firestore/10.20.0/FirebaseFirestoreInternal.zip",
//        checksum: "7fe8f913d35e257979eddc8e2df0fedd3b89735c7030494307079747f03279c7"
//      )
//    }
//  }()
//
//  return [
//    .target(
//      name: "FirebaseFirestore",
//      dependencies: [
//        .target(
//          name: "FirebaseFirestoreInternalWrapper",
//          condition: .when(platforms: [.iOS, .macCatalyst, .tvOS, .macOS])
//        ),
//        .product(name: "abseil", package: "abseil-cpp-binary"),
//        .product(name: "gRPC-C++", package: "grpc-binary"),
//        .product(name: "nanopb", package: "nanopb"),
//        "FirebaseAppCheckInterop",
//        "FirebaseCore",
//        "FirebaseCoreExtension",
//        "leveldb",
//        "FirebaseSharedSwift",
//      ],
//      path: "Firestore/Swift/Source",
//      linkerSettings: [
//        .linkedFramework("SystemConfiguration", .when(platforms: [.iOS, .macOS, .tvOS])),
//        .linkedFramework("UIKit", .when(platforms: [.iOS, .tvOS])),
//        .linkedLibrary("c++"),
//      ]
//    ),
//    .target(
//      name: "FirebaseFirestoreInternalWrapper",
//      dependencies: ["FirebaseFirestoreInternal"],
//      path: "FirebaseFirestoreInternal",
//      publicHeadersPath: "."
//    ),
//    firestoreInternalTarget,
//  ]
//}
//
//extension Platform {
//  // Xcode dependent value for the visionOS platform. Namespaced with
//  // "firebase" prefix to prevent any API collisions (such issues should not
//  // arise as the manifest APIs should be confined to the `Package.swift`).
//  static var firebaseVisionOS: Self {
//    #if swift(>=5.9)
//      // For Xcode 15, return the available `visionOS` platform.
//      return .visionOS
//    #else
//      // For Xcode 14, return `iOS` as visionOS is unavailable. Since all targets
//      // support iOS, this acts as a no-op.
//      return .iOS
//    #endif // swift(>=5.9)
//  }
//}
