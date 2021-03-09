//
//  WeatherModel.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation

struct WeatherModel: Decodable {
    
    // MARK: - CodingKeys
    
    private enum CodingKeys: String, CodingKey {
        case pressure
        case humidity
        case weather
        case temp
    }
    
    // MARK: - Properties
    
    var pressure: Double = 0
    var humidity: Double = 0
    var weather = [WeatherDetailModel]()
    var temp = WeatherTemperatureModel()
    
    var currentWeather: WeatherDetailModel? {
        weather.first
    }
    
    // MARK: - Initialization
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let pressure = try container.decodeIfPresent(Double.self, forKey: .pressure) {
            self.pressure = pressure
        }
        if let humidity = try container.decodeIfPresent(Double.self, forKey: .humidity) {
            self.humidity = humidity
        }
        if let weather = try container.decodeIfPresent([WeatherDetailModel].self, forKey: .weather) {
            self.weather = weather
        }
        if let temp = try container.decodeIfPresent(WeatherTemperatureModel.self, forKey: .temp) {
            self.temp = temp
        }
    }
}
