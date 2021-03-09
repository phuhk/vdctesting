//
//  DependenciesTest.swift
//  OpenWeatherClientTests
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Quick
import Nimble
@testable import OpenWeatherClient

final class DependenciesTest: QuickSpec {

    override func spec() {
        var sut: Factory!
        
        beforeEach {
            sut = FactoryInstance.shared
            register()
        }
        
        afterEach {
            sut = nil
        }
        
        describe("Dependencies") {
            testGetAppCoordinator()
            testGetNetworkReachability()
            testGetAPIManager()
            testGetWeatherForecastRepository()
            testGetWeatherForecastInteractor()
        }
        
        func testGetAppCoordinator() {
            it("should provide AppCoordinator instance") {
                let appCoordinator: AppCoordinator = try! sut.get() as AppCoordinator
                expect(appCoordinator).notTo(beNil())
            }
        }
        
        func testGetNetworkReachability() {
            it("should provide NetworkReachability instance") {
                let networkReachability: NetworkReachability = try! sut.get() as NetworkReachability
                expect(networkReachability).notTo(beNil())
            }
        }
        
        func testGetAPIManager() {
            it("should provide APIManager instance") {
                let apiManager: APIManager<APIProviderTemplate> = try! sut.get() as APIManager<APIProviderTemplate>
                expect(apiManager).notTo(beNil())
            }
        }
        
        func testGetWeatherForecastRepository() {
            it("should provide WeatherForecastRepository instance") {
                let weatherForecastRepository: WeatherForecastRepository = try! sut.get() as WeatherForecastRepository
                expect(weatherForecastRepository).notTo(beNil())
            }
        }
        
        func testGetWeatherForecastInteractor() {
            it("should provide WeatherForecastInteractor instance") {
                let weatherForecastInteractor: WeatherForecastInteractor = try! sut.get() as WeatherForecastInteractor
                expect(weatherForecastInteractor).notTo(beNil())
            }
        }
        
        func register() {
            sut.sign(AppCoordinator.self) {
                MockDependencies.getAppCoordinatorTemplate()
            }
            sut.sign(NetworkReachability.self) {
                MockDependencies.getNetworkReachabilityTemplate()
            }
            sut.sign(APIManager<APIProviderTemplate>.self) {
                MockDependencies.getAPIManagerTemplate(networkReachability: try! sut.get() as NetworkReachability)
            }
            sut.sign(WeatherForecastRepository.self) {
                MockDependencies.getWeatherForecastRepositoryTemplate()
            }
            sut.sign(WeatherForecastInteractor.self) {
                MockDependencies.getWeatherForecastInteractorTemplate(networkReachability: try! sut.get() as NetworkReachability)
            }
        }
    }
}
