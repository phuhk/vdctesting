//
//  URLQueryItemExtension.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation

extension URLQueryItem {
    
    static func queryItems(from parameters: [String: String]) -> [URLQueryItem] {
        parameters.map({ URLQueryItem(name: $0.key, value: $0.value) })
    }
}
