//
//  AdobeAnalyticsEngineConfigurationTests.swift
//  YAnalyticsPendo
//
//  Created by Dev Karan on 4/8/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YAnalyticsAdobe

final class PendoAnalyticsConfigurationTests: XCTestCase {
    func test_defaults() {
        // Given
        let id = "S3cr3t!"
        let sut = AdobeAnalyticsConfiguration(appId: id)

        // Then
        XCTAssertEqual(sut.appId, id)
        XCTAssertEqual(sut.mappings, AdobeEventMapping.default)
        XCTAssertEqual(sut.logLevel, .error)
        XCTAssertEqual(sut.extensions.count, 0)
    }
}
