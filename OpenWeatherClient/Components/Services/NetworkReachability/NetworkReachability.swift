//
//  NetworkReachability.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import RxCocoa

protocol NetworkReachability {
    var isConnected: Bool { get }
    var connected: BehaviorRelay<Bool> { get }
    
    func start()
    func stop()
}
