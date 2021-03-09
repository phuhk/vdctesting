//
//  WeatherForecastContract.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation
import RxCocoa

enum WeatherForecastViewModelContract {
    struct Input: ViewModelInput {
        let searchBarDidChanged: PublishRelay<String>
    }
    
    struct Output: ViewModelOutput {
        let isLoading: Driver<Bool>
        let weatherList: Driver<[WeatherForecastItem]>
        let showErrorPopup: Driver<Bool>
    }
}
