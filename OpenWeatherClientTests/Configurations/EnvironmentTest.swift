//
//  EnvironmentTest.swift
//  OpenWeatherClientTests
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Quick
import Nimble
@testable import OpenWeatherClient

final class EnvironmentTest: QuickSpec {

    override func spec() {
        describe("Environment") {
            testGetCurrentEnvironment()
            testGetAPIEndpointURL()
            testGetOpenWeatherAppId()
        }
    }
    
    func testGetCurrentEnvironment() {
        it("should provide current Environment") {
            let environment = Environment.current
            expect(environment).notTo(beNil())
        }
    }
    
    func testGetAPIEndpointURL() {
        it("should provide API Endpoint URL") {
            let apiEndpointURL = Environment.apiEndpointURL
            expect(apiEndpointURL).notTo(beNil())
        }
    }
    
    func testGetOpenWeatherAppId() {
        it("should provide Open Weather App Id") {
            let openWeatherAppId = Environment.openWeatherAppId
            expect(openWeatherAppId).notTo(beNil())
        }
    }
}
