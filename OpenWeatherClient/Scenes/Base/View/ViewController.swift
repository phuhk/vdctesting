//
//  ViewController.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation
import UIKit

class ViewController<ViewModel: ViewModelType, Input: ViewInput>: BaseViewController<Input>, BindableType {
    
    // MARK: - Properties
    
    var viewModel: ViewModel!
    
    // MARK: - UIViewController Lifecycle
    
    final override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupViewModel()
        bindViewModel()
        viewModel.viewModelDidBind()
    }
    
    func setupViewModel() {
        fatalError("Subsclass must implement this method")
    }
    
    func bindViewModel() {
        fatalError("Subsclass must implement this method")
    }
}
