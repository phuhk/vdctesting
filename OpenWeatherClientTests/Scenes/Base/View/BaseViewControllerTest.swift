//
//  BaseViewControllerTest.swift
//  OpenWeatherClientTests
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Quick
import Nimble
import RxSwift
import RxCocoa
@testable import OpenWeatherClient

final class BaseViewControllerTest: QuickSpec {

    override func spec() {
        
        var sut: BaseViewController<EmptyViewInput>!
        
        beforeEach {
            sut = BaseViewController<EmptyViewInput>()
        }
        
        afterEach {
            sut = nil
        }
        
        describe("viewDidLoad") {
            beforeEach {
                // Trigger the necessary methods to render the view.
                let _ = sut.view
            }
            
            it("should run correctly") {
                expect(sut.isViewLoaded).toEventually(equal(true))
            }
            
            it("disposeBag should be initialized") {
                let disposebag = sut.rx.disposeBag
                expect(disposebag).notTo(beNil())
            }
        }
        
        describe("show No Connection Alert") {
            context("Run into network issue") {
                beforeEach {
                    sut.present(sut.noConnectionAlert,
                                           animated: false,
                                           completion: nil)
                }
                it("should present No Connection Alert") {
                    expect(sut.noConnectionAlert.isBeingPresented).to(beFalse())
                }
            }
        }
        
        describe("viewDidAppear") {
            it("should be call") {
                sut.viewDidAppear(true)
            }
        }
        
        describe("viewDidDisappear") {
            it("should be call") {
                sut.viewDidDisappear(true)
            }
        }
    }
}
