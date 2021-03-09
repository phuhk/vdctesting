//
//  BaseViewController.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class BaseViewController<Input: ViewInput>: UIViewController {
    
    // MARK: - Properties
    
    lazy var noConnectionAlert: UIAlertController = {
        let noConnectionAlert = UIAlertController(title: "",
                                                  message: "Networking issue",
                                                  preferredStyle: .alert)
        noConnectionAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return noConnectionAlert
    }()
    
    private(set) var input: Input!
    
    // MARK: - Dealloc
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("deinit " + String(describing: self))
    }
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViewDidLoad()
        setupUI()
        setupConstraints()
        bindView()
    }
    
    // Methods
    
    func enableDimissKeyboardWhenTap() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    @objc func endEditing() {
        view.endEditing(true)
    }
    
    // MARK: - Private Methods
    
    func setupViewDidLoad() {}
    
    func setupUI() {
        view.isOpaque = false
        view.backgroundColor = UIColor.background
    }
    
    func setupConstraints() {
        view.autoresizingMask = []
        view.autoresizesSubviews = false
    }
    
    func bindView() {
        
    }
}
