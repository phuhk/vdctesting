//
//  AppCoordinatorInstance.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation
import UIKit

final class AppCoordinatorInstance: AppCoordinator {
    
    // MARK: - Initialization
    
    init() {
        
    }
    
    // MARK: - AppCoordinator
    
    func makeRootView() -> UIViewController {
        let rootViewController = BaseNavigationController()
        rootViewController.viewControllers = [makeWeatherForecastScene()]
        return rootViewController
    }
    
    func makeWeatherForecastScene() -> WeatherForecastViewController {
        WeatherForecastViewController()
    }
}
