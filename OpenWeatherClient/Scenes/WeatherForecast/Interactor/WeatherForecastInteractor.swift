//
//  WeatherForecastInteractor.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation
import RxSwift

protocol WeatherForecastInteractor {
    var networkReachability: NetworkReachability { get }
    
    func getDailyForecast(_ city: String) -> Single<WeatherForecastModel>
}

// MARK: -

final class WeatherForecastInteractorInstance: WeatherForecastInteractor {
    
    // MARK: - Properties
    
    private let repository: WeatherForecastRepository
    let networkReachability: NetworkReachability
    
    // MARK: - Initialization
    
    init(repository: WeatherForecastRepository,
         networkReachability: NetworkReachability) {
        self.repository = repository
        self.networkReachability = networkReachability
    }
    
    // MARK: - WeatherForecastInteractor
    
    func getDailyForecast(_ city: String) -> Single<WeatherForecastModel> {
        repository.getDailyForecast(city: city,
                                    numberOfDays: 7,
                                    units: "metric")
    }
}
