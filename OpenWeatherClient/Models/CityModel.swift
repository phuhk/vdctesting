//
//  CityModel.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation

struct CityModel: Decodable {
    
    // MARK: - CodingKeys
    
    private enum CodingKeys: String, CodingKey {
        case name
    }
    
    // MARK: - Properties
    
    var name: String = ""
    
    // MARK: - Initialization
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let name = try container.decodeIfPresent(String.self, forKey: .name) {
            self.name = name
        }
    }
}
