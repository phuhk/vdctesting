//
//  BindableType.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation
import UIKit

protocol BindableType where Self: UIResponder {
    
    associatedtype ViewModel
    var viewModel: ViewModel! { get set }
    
    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    func bind(to viewModel: Self.ViewModel) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        bindViewModel()
    }
}

extension BindableType where Self: UIView {
    func bind(to viewModel: Self.ViewModel) {
        self.viewModel = viewModel
        bindViewModel()
    }
}
