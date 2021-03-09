//
//  NetworkReachabilityInstance.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation
import Reachability
import RxCocoa
import RxReachability

final class NetworkReachabilityInstance: NSObject, NetworkReachability {
    
    // MARK: - Properties
    
    private let reachability: Reachability
    
    var isConnected: Bool {
        reachability.connection == .wifi ||
        reachability.connection == .cellular
    }
    
    var connected =  BehaviorRelay<Bool>(value: true)
    
    // MARK: - Initialization
    
    override init() {
        self.reachability = try! Reachability()
        super.init()
        self.reachability
            .rx
            .isReachable
            .bind(to: connected)
            .disposed(by: rx.disposeBag)
    }
    
    // Methods
    
    func start() {
        try? reachability.startNotifier()
    }
    
    func stop() {
        reachability.stopNotifier()
    }
}
