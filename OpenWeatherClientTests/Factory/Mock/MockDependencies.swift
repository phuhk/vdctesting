//
//  MockDependencies.swift
//  OpenWeatherClientTests
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import RxSwift
import RxCocoa

struct MockDependencies {
    
    static func getAppCoordinatorTemplate() -> AppCoordinator {
        AppCoordinatorTemplate()
    }
    
    static func getNetworkReachabilityTemplate() -> NetworkReachability {
        NetworkReachabilityTemplate()
    }
    
    static func getAPIManagerTemplate(networkReachability: NetworkReachability) -> APIManager<APIProviderTemplate> {
        APIManager<APIProviderTemplate>(networkReachability: networkReachability)
    }
    
    static func getWeatherForecastRepositoryTemplate() -> WeatherForecastRepository {
        WeatherForecastRepositoryTemplate()
    }
    
    static func getWeatherForecastInteractorTemplate(networkReachability: NetworkReachability) -> WeatherForecastInteractor {
        WeatherForecastInteractorTemplate(networkReachability: networkReachability)
    }
}

final class AppCoordinatorTemplate: AppCoordinator {
    func makeRootView() -> UIViewController {
        UIViewController()
    }
    
    func makeWeatherForecastScene() -> WeatherForecastViewController {
        WeatherForecastViewController()
    }
}

struct NetworkReachabilityTemplate: NetworkReachability {
    var isConnected = true
    var connected = BehaviorRelay<Bool>(value: true)
    
    func start() {}
    func stop() {}
}

struct APIProviderTemplate: APIProvider {
    var baseURL = "https://www.google.com/"
    var path = ""
    var endpoint = ""
    var method = HTTPMethod.get
    var request: URLRequest {
        URLRequest(url: URL(string: baseURL + path)!)
    }
}

struct WeatherForecastRepositoryTemplate: WeatherForecastRepository {
    func getDailyForecast(city: String,
                          numberOfDays: Int,
                          units: String) -> Single<WeatherForecastModel> {
        Single.just(WeatherForecastModel())
    }
}

struct WeatherForecastInteractorTemplate: WeatherForecastInteractor {
    var networkReachability: NetworkReachability
    
    func getDailyForecast(_ city: String) -> Single<WeatherForecastModel> {
        guard city == "Melbourne" else {
            return Single.error(ApiError.network)
        }
        var weatherModel = WeatherForecastModel()
        weatherModel.list = [WeatherModel(), WeatherModel(), WeatherModel()]
        return Single.just(weatherModel)
    }
}
