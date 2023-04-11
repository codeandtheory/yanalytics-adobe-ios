//
//  AdobeEventMappingTests.swift
//  YAnalyticsPendo
//
//  Created by Dev Karan on 4/8/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import YAnalytics
@testable import YAnalyticsAdobe

final class PendoEventMappingTests: XCTestCase {
    func test_default() {
        // Given
        let sut = AdobeEventMapping.defaultEvent

        // Then
        XCTAssertTrue(sut.name.isEmpty)
        XCTAssertTrue(sut.topLevelKey.isEmpty)
        XCTAssertEqual(sut.type, .state)
    }
    
    func test_defaultScreenView() {
        // Given
        let sut = AdobeEventMapping.defaultScreenView

        // Then
        XCTAssertEqual(sut.name, AnalyticsEvent.screenViewKey)
        XCTAssertEqual(sut.topLevelKey, "screenName")
        XCTAssertEqual(sut.type, .action)
    }
    
    func test_defaultUserProperty() {
        // Given
        let sut = AdobeEventMapping.defaultUserProperty

        // Then
        XCTAssertEqual(sut.type, .state)
        XCTAssertEqual(sut.name, AnalyticsEvent.eventKey)
    }

    func test_defaultEvent() {
        // Given
        let sut = AdobeEventMapping.defaultEvent

        // Then
        XCTAssertEqual(sut.type, .state)
    }

    func test_defaultMapping() {
        // Given
        let sut = AdobeEventMapping.default

        // Then
        XCTAssertEqual(sut.count, 3)
        XCTAssertEqual(sut[AnalyticsEvent.screenViewKey], AdobeEventMapping.defaultScreenView)
        XCTAssertEqual(sut[AnalyticsEvent.userPropertyKey], AdobeEventMapping.defaultUserProperty)
        XCTAssertEqual(sut[AnalyticsEvent.eventKey], AdobeEventMapping.defaultEvent)
    }
}
