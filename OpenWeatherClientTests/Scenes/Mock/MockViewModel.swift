//
//  MockViewModel.swift
//  OpenWeatherClientTests
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

struct MockViewModel: ViewModelType {
    typealias Input = ViewModelInput
    typealias Output = ViewModelOutput
    typealias Dependency = NSObject
    
    var inputs: Input
    var outputs: Output!
    var dependencies: Dependency
    
    var isLoading: BehaviorRelay<Bool>
    
    func transform() {}
    func viewModelDidBind() {}
}
