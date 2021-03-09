//
//  Dependencies.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation

struct Dependencies {
    
    static func register() {
        registerAppCoordinator()
        registerServices()
        registerManagers()
        registerRepositories()
        registerInteractors()
    }
    
    private static func registerAppCoordinator() {
        FactoryInstance.shared.sign(AppCoordinator.self) {
            AppCoordinatorInstance()
        }
    }
    
    private static func registerServices() {
        FactoryInstance.shared.sign(NetworkReachability.self) {
            NetworkReachabilityInstance()
        }
    }
    
    private static func registerManagers() {
        FactoryInstance.shared.sign(APIManager<APIWeatherForecastProvider>.self) {
            APIManager<APIWeatherForecastProvider>(networkReachability: getService())
        }
    }
    
    private static func registerRepositories() {
        FactoryInstance.shared.sign(WeatherForecastRepository.self) {
            WeatherForecastRepositoryInstance(provider: getManager())
        }
    }
    
    private static func registerInteractors() {
        FactoryInstance.shared.sign(WeatherForecastInteractor.self) {
            WeatherForecastInteractorInstance(repository: getRepository(),
                                              networkReachability: getService())
        }
    }
}

// MARK: -

extension Dependencies {
    static func getAppCoordinator<AppCoordinator>() -> AppCoordinator {
        return try! FactoryInstance.shared.get() as AppCoordinator
    }
    
    static func getManager<Manager>() -> Manager {
        return try! FactoryInstance.shared.get() as Manager
    }
    
    static func getService<Service>() -> Service {
        return try! FactoryInstance.shared.get() as Service
    }
    
    static func getRepository<Repository>() -> Repository {
        return try! FactoryInstance.shared.get() as Repository
    }
    
    static func getInteractor<Interactor>() -> Interactor {
        return try! FactoryInstance.shared.get() as Interactor
    }
}
