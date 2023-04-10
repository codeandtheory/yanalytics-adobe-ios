//
//  AdobeAnalyticsEngine.swift
//  YAnalyticsAdobe
//
//  Created by Sumit Goswami on 13/10/21.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation
import AEPCore
import AEPAnalytics
import YAnalytics

/// Adobe Analytics Engine
final public class AdobeAnalyticsEngine {
    /// Info for mapping `AnalyticsEvent` events to Adobe events
    public let mappings: [String: AdobeEventMapping]

    /// Initialize Adobe Engine
    ///
    /// You should declare a single instance of the `AdobeAnalyticsEngine` (but not a singleton!)
    /// and you probably want to do so at app launch and have its lifecycle map that of your application.
    /// - Parameter configuration: configuration for Adobe Analytics
    public init(configuration: AdobeAnalyticsConfiguration) {
        mappings = configuration.mappings

        MobileCore.registerExtensions(configuration.extensions) {
            MobileCore.configureWith(appId: configuration.appId)
        }

        MobileCore.setLogLevel(configuration.logLevel)
    }
}

// MARK: - AnalyticsEngine

/// Conform to `AnalyticsEngine` protocol
extension AdobeAnalyticsEngine: AnalyticsEngine {
    /// Track an analytics event
    /// - Parameter event: the event to log
    public func track(event: AnalyticsEvent) {
        let mapping: AdobeEventMapping
        let name: String?
        let data: Metadata?

        switch event {
        case .screenView(let screenName):
            mapping = mappings[AnalyticsEvent.screenViewKey] ?? AdobeEventMapping.defaultScreenView
            name = mapping.name
            data = [mapping.topLevelKey: screenName]
        case .userProperty(let propertyName, let value):
            mapping = mappings[AnalyticsEvent.userPropertyKey] ?? AdobeEventMapping.defaultUserProperty
            name = mapping.name
            data = [propertyName: value]
        case .event(let eventName, let parameters):
            mapping = mappings[AnalyticsEvent.eventKey] ?? AdobeEventMapping.defaultEvent
            name = eventName
            data = parameters
        }

        track(type: mapping.type, name: name, data: data)
    }

    private func track(type: AdobeEventType, name: String?, data: [String: Any]?) {
        switch type {
        case .action:
            MobileCore.track(action: name, data: data)
        case .state:
            MobileCore.track(state: name, data: data)
        }
    }
}
