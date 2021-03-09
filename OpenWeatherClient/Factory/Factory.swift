//
//  Factory.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation

protocol Factory {
    typealias Resolver<Contract> = () throws -> Contract
    func sign<Contract>(_ contract: Contract.Type, resolver: @escaping Resolver<Contract>)
    func resign<Contract>(_ contract: Contract.Type)
    func resignAllContract()
    func get<Contract>() throws -> Contract
}

enum FactoryError: Error {
    case notFound
    case notAvailable
}
