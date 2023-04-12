//
//  AdobeAnalyticsEngineTests.swift
//  YAnalyticsAdobe
//
//  Created by Mark Pospesel on 10/13/21.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YAnalytics
@testable import YAnalyticsAdobe

final class AdobeAnalyticsEngineTests: XCTestCase {
    func test_defaultMapping() throws {
        // Given
        let config = AdobeAnalyticsConfiguration(appId: "S3cr3t!")
        let sut = makeSUT(config: config)
        var data = MockAnalyticsData()
        let engine = try XCTUnwrap(sut.engine as? AdobeAnalyticsEngine)
        XCTAssertTrue(sut.mock.allEvents.isEmpty)
        
        // When
        data.allEvents.forEach { sut.track(event: $0) }
        
        // Then
        XCTAssertEqual(engine.mappings, AdobeEventMapping.default)
        XCTAssertLogged(engine: sut, data: data)
    }
    
    func test_customMapping() throws {
        // Given
        let screenView = AdobeEventMapping(
            type: .action,
            name: "custom",
            topLevelKey: "whatever"
        )
        let userProperty = AdobeEventMapping(
            type: .state
        )
        let mapping: [String: AdobeEventMapping] = [
            AnalyticsEvent.screenViewKey: screenView,
            AnalyticsEvent.userPropertyKey: userProperty
        ]
        let config = AdobeAnalyticsConfiguration(appId: "S3cr3t!", mappings: mapping)
        let sut = makeSUT(config: config)
        var data = MockAnalyticsData()
        let engine = try XCTUnwrap(sut.engine as? AdobeAnalyticsEngine)
        XCTAssertTrue(sut.mock.allEvents.isEmpty)

        // When
        data.allEvents.forEach { sut.track(event: $0) }

        // Then
        XCTAssertEqual(engine.mappings, mapping)
        XCTAssertLogged(engine: sut, data: data)
    }
    
    func test_emptyMappings() throws {
        // Given a configuration with no mappings
        let config = AdobeAnalyticsConfiguration(appId: "S3cr3t!", mappings: [:])
        let sut = makeSUT(config: config)
        var data = MockAnalyticsData()
        let engine = try XCTUnwrap(sut.engine as? AdobeAnalyticsEngine)
        XCTAssertTrue(sut.mock.allEvents.isEmpty)

        // When
        data.allEvents.forEach { sut.track(event: $0) }

        // Then
        XCTAssertTrue(engine.mappings.isEmpty)
        XCTAssertLogged(engine: sut, data: data)
    }
}

private extension AdobeAnalyticsEngineTests {
    func makeSUT(
        config: AdobeAnalyticsConfiguration,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> SpyAnalyticsEngine {
        let engine = AdobeAnalyticsEngine(configuration: config)
        let sut = SpyAnalyticsEngine(engine: engine)
        trackForMemoryLeak(engine, file: file, line: line)
        trackForMemoryLeak(sut, file: file, line: line)
        return sut
    }
}
