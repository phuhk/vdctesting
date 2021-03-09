//
//  WeatherForecastRepository.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation
import RxSwift

protocol WeatherForecastRepository {
    func getDailyForecast(city: String,
                          numberOfDays: Int,
                          units: String) -> Single<WeatherForecastModel>
}

// MARK: -

final class WeatherForecastRepositoryInstance: WeatherForecastRepository {
    
    // MARK: - Properties
    
    private let provider: APIManager<APIWeatherForecastProvider>
    
    // MARK: - Initialization
    
    init(provider: APIManager<APIWeatherForecastProvider>) {
        self.provider = provider
    }
    
    // MARK: - WeatherForecastRepository
    
    func getDailyForecast(city: String,
                          numberOfDays: Int,
                          units: String) -> Single<WeatherForecastModel> {
        provider.request(.getDailyForecast(city: city,
                                           numberOfDays: numberOfDays,
                                           units: units))
    }
}
