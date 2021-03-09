//
//  BaseNavigationController.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import UIKit
import RxCocoa

final class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    private var isPushing = false
    
    // MARK: - Dealloc
    
    deinit {
        print("deinit " + String(describing: self))
    }
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        delegate = self
        setupUI()
        setupConstraints()
        registerStream()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.isOpaque = false
    }
    
    func setupConstraints() {
        view.autoresizingMask = []
        view.autoresizesSubviews = false
    }
    
    private func registerStream() {
        rx.didShow
            .subscribe(onNext: { [unowned self] _ in
                self.isPushing = false
            })
            .disposed(by: rx.disposeBag)
    }
    
    // MARK: - Override Methods
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        guard !isPushing else { return }
        isPushing = true
        pushViewController(viewController, animated: animated)
    }
}
