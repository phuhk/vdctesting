//
//  Environment.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation

/// Environment communicator
enum Environment: String {
    case beta
    
    // MARK: - Properties
    
    /// Get current environment.
    static var current: Environment {
        Environment(rawValue: stringValue(ConfigurationKey.environment))!
    }
    
    /// Get API Endpoint URL.
    static var apiEndpointURL: String {
        Environment.stringValue(ConfigurationKey.apiEndpointURL)
            .replacingOccurrences(of: "\\", with: "")
    }
    
    /// Get Open Weather App Id.
    static var openWeatherAppId: String {
        Environment.stringValue(ConfigurationKey.openWeatherAppId)
    }
    
    // MARK: - Private Methods
    
    /// Reading the `String` value of configuration `key`.
    ///
    /// - Parameter key: configuration `key`
    /// - Returns: the `String` value of configuration `key`
    private static func stringValue(_ key: ConfigurationKey) -> String {
        Bundle.main.value(from: key)
    }
}

// MARK: -

/// Configurable information `key`.
enum ConfigurationKey: String {
    
    case environment = "Environment"
    
    // Endpoints
    case apiEndpointURL = "APIEndpointURL"
    
    // OpenWeather
    case openWeatherAppId = "OpenWeatherAppId"
}

// MARK: -

extension Bundle {
    
    /// Get the value of configuration `key`.
    ///
    /// - Parameter key: configuration `key`
    /// - Returns: the value of configuration `key`
    func value<T>(from key: ConfigurationKey) -> T {
        Bundle.main.object(forInfoDictionaryKey: key.rawValue) as! T
    }
}
