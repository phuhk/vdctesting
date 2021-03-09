//
//  WeatherDetailModel.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation

struct WeatherDetailModel: Decodable {
    
    // MARK: - CodingKeys
    
    private enum CodingKeys: String, CodingKey {
        case description
    }
    
    // MARK: - Properties
    
    var description: String = ""
    
    // MARK: - Initialization
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let description = try container.decodeIfPresent(String.self, forKey: .description) {
            self.description = description
        }
    }
}
