//
//  FactoryInstance.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation

final class FactoryInstance: Factory {
    
    // MARK: - Properties
    
    static let shared = FactoryInstance()
    private var dependencies: [String: Resolver<Any>] = [:]
    
    // MARK: - Initialization
    
    private init() {}

    /// Register `Resolver` for `Contract`.
    ///
    /// - Parameters:
    ///   - contract: the `Contract` to resolve
    ///   - resolver: the `Resolver` to resolve the implementation of `Contract`
    func sign<Contract>(_ contract: Contract.Type, resolver: @escaping () throws -> Contract) {
        dependencies["\(Contract.self)"] = resolver
    }

    /// Resign `Contract`.
    ///
    /// - Parameters:
    ///   - contract: the `Contract` to regisn
    func resign<Contract>(_ contract: Contract.Type) {
        dependencies.removeValue(forKey: "\(Contract.self)")
    }

    /// Resign all `Contract`.
    func resignAllContract() {
        dependencies.removeAll()
    }

    /// Get `Resolver` of `Contract`.
    ///
    /// - Returns: the `Resolver` of `Contract`
    func get<Contract>() throws -> Contract {
        let signature = "\(Contract.self)"
        guard let resolver = dependencies[signature] else {
            throw FactoryError.notFound
        }
        guard let instance = try resolver() as? Contract else {
            throw FactoryError.notAvailable
        }
        return instance
    }
}
