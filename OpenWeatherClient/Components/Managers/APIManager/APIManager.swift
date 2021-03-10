//
//  APIManager.swift
//  OpenWeatherClient
//
//  Created by Huỳnh Kỳ Phú on 06/03/2021.
//

import Foundation
import RxSwift

struct APIManager<Provider: APIProvider> {
    
    // MARK: - Properties
    
    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    private let networkReachability: NetworkReachability
    
    // MARK: - Initialization
    
    init(networkReachability: NetworkReachability) {
        self.networkReachability = networkReachability
    }
    
    // MARK: - Methods
    
    func request<T: Decodable>(_ provider: Provider) -> Single<T> {
        guard networkReachability.isConnected else { return Single.error(ApiError.network) }
        return URLSession.shared.rx.response(request: provider.request)
            .flatMapLatest { (response: HTTPURLResponse, data: Data) -> Observable<T> in
                guard response.statusCode == 200 else {
                    return Observable.error(ApiError.unsuccessful)
                }
                do {
                    let object = try APIManager.decoder.decode(T.self, from: data)
                    return Observable.just(object)
                } catch let error {
                    print("\(T.self) decode error \(error.localizedDescription)")
                }
                return Observable.error(ApiError.decodeIssue)
            }
            .asSingle()
    }
}

protocol APIProvider {
    var baseURL: String { get }
    var path: String { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var request: URLRequest { get }
}

enum ApiError: Error {
    case unknown
    case network
    case unsuccessful
    case decodeIssue
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
