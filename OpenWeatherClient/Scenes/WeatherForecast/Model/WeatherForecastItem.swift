//
//  WeatherForecastItem.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation

struct WeatherForecastItem {
    
    let averageTemperature: String
    let pressure: String
    let humidity: String
    let description: String
    
    var text: String {
        """
        Average Temperature: \(averageTemperature)
        Pressure: \(pressure)
        Humidity: \(humidity)
        Description: \(description)
        """
    }
    
    init(from model: WeatherModel) {
        self.averageTemperature = String(format: "%.1f°C", model.temp.average)
        self.pressure = "\(Int(model.pressure))"
        self.humidity = "\(Int(model.humidity))%"
        self.description = model.currentWeather?.description ?? ""
    }
}
