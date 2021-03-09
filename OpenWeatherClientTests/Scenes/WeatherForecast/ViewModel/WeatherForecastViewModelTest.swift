//
//  WeatherForecastViewModelTest.swift
//  OpenWeatherClientTests
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import XCTest
import Quick
import Nimble
import RxSwift
import RxCocoa
import RxTest
import RxBlocking
import Action
@testable import OpenWeatherClient

final class WeatherForecastViewModelTest: QuickSpec {

    override func spec() {
        var sut: WeatherForecastViewModel!
        var scheduler: TestScheduler!
        let searchBarInputTrigger = PublishRelay<String>()
        
        beforeEach {
            scheduler = TestScheduler(initialClock: 0)
            let inputs = WeatherForecastViewModelContract.Input(searchBarDidChanged: searchBarInputTrigger)
            let mockNetworkReachability = NetworkReachabilityTemplate()
            let mockWeatherForecastInteractor = WeatherForecastInteractorTemplate(networkReachability: mockNetworkReachability)
            sut = WeatherForecastViewModel(inputs: inputs,
                                           dependencies: mockWeatherForecastInteractor)
        }
        
        afterEach {
            sut = nil
        }
        
        describe("transform") {
            it("should invoked") {
                expect(sut.outputs).notTo(beNil())
            }
        }
        
        describe("WeatherForecastViewModel Output") {
            it("isLoading") {
                let isLoading = scheduler.createObserver(Bool.self)
                sut
                    .outputs
                    .isLoading
                    .skip(1)
                    .drive(isLoading)
                    .disposed(by: self.rx.disposeBag)
                sut.getDailyForecast.execute("abc")
                XCTAssert(isLoading.events.first?.value.element == true)
                XCTAssert(isLoading.events.last?.value.element == false)
            }
            
            it("weatherList has value") {
                let list = scheduler.createObserver([WeatherForecastItem].self)
                sut
                    .outputs
                    .weatherList
                    .skip(1)
                    .drive(list)
                    .disposed(by: self.rx.disposeBag)
                sut.getDailyForecast.execute("Melbourne")
                XCTAssertFalse(list.events.isEmpty)
            }
            
            it("weatherList empty value") {
                let list = scheduler.createObserver([WeatherForecastItem].self)
                sut
                    .outputs
                    .weatherList
                    .skip(1)
                    .drive(list)
                    .disposed(by: self.rx.disposeBag)
                sut.getDailyForecast.execute("abc")
                XCTAssertTrue(list.events.isEmpty)
            }
            
            it("showErrorPopup") {
                let showErrorPopup = scheduler.createObserver(Bool.self)
                sut
                    .outputs
                    .showErrorPopup
                    .drive(showErrorPopup)
                    .disposed(by: self.rx.disposeBag)
                sut.getDailyForecast.execute("abc")
                XCTAssert(showErrorPopup.events.last?.value.element == true)
            }
        }
    }
}
