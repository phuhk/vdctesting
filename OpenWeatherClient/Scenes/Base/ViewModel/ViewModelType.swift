//
//  ViewModelType.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    associatedtype Dependency
    
    var inputs: Input { get }
    var outputs: Output! { get }
    var dependencies: Dependency { get }
    
    var isLoading: BehaviorRelay<Bool> { get set }
        
    func transform()
    func viewModelDidBind()
}
