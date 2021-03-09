//
//  BaseViewModel.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel<Input: ViewModelInput, Output: ViewModelOutput, Dependency>: NSObject, ViewModelType {
    
    // MARK: - Properties
    
    let inputs: Input
    private(set) var outputs: Output!
    let dependencies: Dependency
    
    var isLoading = BehaviorRelay<Bool>(value: false)
    
    // MARK: - Initialization
    
    init(inputs: Input,
         dependencies: Dependency = Dependencies.getInteractor()) {
        self.inputs = inputs
        self.dependencies = dependencies
        super.init()
        transform()
    }
    
    // MARK: - Methods
    
    final func setOutput(_ outputs: Output) {
        self.outputs = outputs
    }
    
    // MARK: - Override Methods
    
    func transform() {
        fatalError("Subsclass must implement this method")
    }
    
    func viewModelDidBind() {
        fatalError("Subsclass must implement this method")
    }
}
