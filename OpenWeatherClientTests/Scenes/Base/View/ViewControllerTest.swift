//
//  ViewControllerTest.swift
//  OpenWeatherClientTests
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Quick
import Nimble
import RxSwift
import RxCocoa
@testable import OpenWeatherClient

final class ViewControllerTest: QuickSpec {

    override func spec() {
        var sut: ViewController<MockViewModel, EmptyViewInput>!
        
        beforeEach {
            sut = ViewController()
        }
        
        afterEach {
            sut = nil
        }
        
        describe("ViewController") {
            func testSubclassError() {
                expectFatalError(expectedMessage: "Subsclass must implement this method") {
                    sut.setupViewModel()
                }
                
                expectFatalError(expectedMessage: "Subsclass must implement this method") {
                    sut.bindViewModel()
                }
            }
        }
    }
}
