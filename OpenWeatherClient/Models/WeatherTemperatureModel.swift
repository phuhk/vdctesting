//
//  WeatherTemperatureModel.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation

struct WeatherTemperatureModel: Decodable {
    
    // MARK: - CodingKeys
    
    private enum CodingKeys: String, CodingKey {
        case min
        case max
    }
    
    // MARK: - Properties
    
    var min: Double = 0
    var max: Double = 0
    
    var average: Double {
        (min + max) / 2
    }
    
    // MARK: - Initialization
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let min = try container.decodeIfPresent(Double.self, forKey: .min) {
            self.min = min
        }
        if let max = try container.decodeIfPresent(Double.self, forKey: .max) {
            self.max = max
        }
    }
}
