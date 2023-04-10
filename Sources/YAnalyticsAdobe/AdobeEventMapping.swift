//
//  AdobeEventMapping.swift
//  YAnalyticsAdobe
//
//  Created by Mark Pospesel on 11/24/21.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation
import YAnalytics

/// Information for mapping from `AnalyticsEvent` to Adobe events
public struct AdobeEventMapping: Equatable {
    /// Adobe event type (action or state)
    public let type: AdobeEventType
    /// Adobe event name (used when mapping from `AnalyticsEvent.screenView` and `AnalyticsEvent.userProperty`)
    public let name: String
    /// Top-level key for Adobe event data dictionary (used when mapping from `AnalyticsEvent.screenView`)
    public let topLevelKey: String

    /// Initialize mapping info
    /// - Parameters:
    ///   - type: Adobe event type (action or state)
    ///   - name: Adobe event name (not used for `AnalyticsEvent.event`)
    ///   - topLevelKey: data dictionary top-level key (used only for `AnalyticEvent.screenView`)
    public init(type: AdobeEventType, name: String = "", topLevelKey: String = "") {
        self.type = type
        self.name = name
        self.topLevelKey = topLevelKey
    }
}

public extension AdobeEventMapping {
    /// default mapping from `AnalyticsEvent.screenView`
    static let defaultScreenView = AdobeEventMapping(
        type: .action,
        name: AnalyticsEvent.screenViewKey,
        topLevelKey: "screenName"
    )

    /// default mapping from `AnalyticsEvent.userProperty`
    static let defaultUserProperty = AdobeEventMapping(type: .state, name: AnalyticsEvent.eventKey)
    
    /// default mapping from `AnalyticsEvent.event`
    static let defaultEvent = AdobeEventMapping(type: .state)

    /// default mappings from all `AnalyticsEvent` cases to Adobe events
    static let `default`: [String: AdobeEventMapping] = [
        AnalyticsEvent.screenViewKey: .defaultScreenView,
        AnalyticsEvent.userPropertyKey: .defaultUserProperty,
        AnalyticsEvent.eventKey: .defaultEvent
    ]
}
