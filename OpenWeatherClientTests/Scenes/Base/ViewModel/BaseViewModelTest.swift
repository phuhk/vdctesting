//
//  BaseViewModelTest.swift
//  OpenWeatherClientTests
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Quick
import Nimble
import RxSwift
import RxCocoa
@testable import OpenWeatherClient

final class BaseViewModelTest: QuickSpec {
    
    override func spec() {
        var sut: MockViewModel!
        
        beforeEach {
            sut = MockViewModel(inputs: EmptyViewModelInput(),
                                dependencies: NSObject(),
                                isLoading: BehaviorRelay(value: true))
        }
        
        afterEach {
            sut = nil
        }
        
        describe("BaseViewModel") {
            testSubclassError()
            
            describe("isLoading") {
                it("isLoading should true") {
                    let isLoading = BehaviorRelay<Bool>(value: false)
                    sut
                        .isLoading
                        .bind(to: isLoading)
                        .disposed(by: self.rx.disposeBag)
                    sut.isLoading.accept(true)
                    expect(isLoading.value).to(equal(true))
                }
                
                it("isLoading should false") {
                    let isLoading = BehaviorRelay<Bool>(value: false)
                    sut
                        .isLoading
                        .bind(to: isLoading)
                        .disposed(by: self.rx.disposeBag)
                    sut.isLoading.accept(false)
                    expect(isLoading.value).to(equal(false))
                }
            }
        }
        
        func testSubclassError() {
            expectFatalError(expectedMessage: "Subsclass must implement this method") {
                _ = BaseViewModel<EmptyViewModelInput, EmptyViewModelOutput, NSObject>(inputs: EmptyViewModelInput(), dependencies: NSObject())
            }
            
            expectFatalError(expectedMessage: "Subsclass must implement this method") {
                let mockBaseViewModel = BaseViewModel<EmptyViewModelInput, EmptyViewModelOutput, NSObject>(inputs: EmptyViewModelInput(), dependencies: NSObject())
                mockBaseViewModel.viewModelDidBind()
            }
        }
    }
}
