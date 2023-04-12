//
//  AdobeConfiguration.swift
//  YAnalyticsAdobe
//
//  Created by Sumit Goswami on 22/11/21.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation
import AEPCore
import AEPAnalytics
import AEPServices

/// Required parameters for Adobe Analytics Engine
public struct AdobeAnalyticsConfiguration {
    /// Extensions to register with Adobe
    public let extensions: [NSObject.Type]

    /// Application ID to configure with Adobe
    public let appId: String

    /// Logging level to use
    public let logLevel: LogLevel

    /// Information for mapping from `AnalyticsEvent` to Adobe events
    public let mappings: [String: AdobeEventMapping]

    /// Initializes the required parameters for configuring the Adobe Analytics Engine
    /// - Parameters:
    ///   - extensions: extensions to register with Adobe (default = `[]`)
    ///   - appId: application ID to configure with Adobe
    ///   - logLevel: logging level to use (default = `.error`)
    ///   - mapping: info for mapping `AnalyticsEvent` events to Adobe events.
    ///   Defaults to `AdobeEventMapping.default`.
    public init(
        extensions: [NSObject.Type] = [],
        appId: String,
        logLevel: LogLevel = .error,
        mappings: [String: AdobeEventMapping] = AdobeEventMapping.default
    ) {
        self.extensions = extensions
        self.appId = appId
        self.logLevel = logLevel
        self.mappings = mappings
    }
}
