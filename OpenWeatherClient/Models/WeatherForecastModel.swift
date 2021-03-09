//
//  WeatherForecastModel.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation

struct WeatherForecastModel: Decodable {
    
    // MARK: - CodingKeys
    
    private enum CodingKeys: String, CodingKey {
        case city
        case list
    }
    
    // MARK: - Properties
    
    var city = CityModel()
    var list = [WeatherModel]()
    
    // MARK: - Initialization
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let city = try container.decodeIfPresent(CityModel.self, forKey: .city) {
            self.city = city
        }
        if let list = try container.decodeIfPresent([WeatherModel].self, forKey: .list) {
            self.list = list
        }
    }
}
