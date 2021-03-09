//
//  APIWeatherForecastProvider.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation

enum APIWeatherForecastProvider: APIProvider {
    case getDailyForecast(city: String, numberOfDays: Int, units: String)
    
    var baseURL: String {
        Environment.apiEndpointURL
    }
    
    var path: String {
        switch self {
        case .getDailyForecast: return "forecast/daily"
        }
    }
    
    var endpoint: String {
        baseURL + path
    }
    
    var method: HTTPMethod {
        switch self {
        case .getDailyForecast: return .get
        }
    }
    
    var request: URLRequest {
        switch self {
        case .getDailyForecast(let city, let numberOfDays, let units):
            var urlComponents = URLComponents(string: endpoint)!
            let parameters: [String: String] = [
                "q": city,
                "cnt": String(numberOfDays),
                "units": units,
                "appid": Environment.openWeatherAppId
            ]
            urlComponents.queryItems = URLQueryItem.queryItems(from: parameters)
            var request = URLRequest(url: urlComponents.url!)
            request.httpMethod = method.rawValue
            return request
        }
    }
}
