//
//  AppCoordinator.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation
import UIKit

protocol AppCoordinator: class {
    // Factory
    func makeRootView() -> UIViewController
    func makeWeatherForecastScene() -> WeatherForecastViewController
}
