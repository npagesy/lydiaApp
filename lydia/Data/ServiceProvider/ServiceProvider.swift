//
//  ServiceProviderProtocols.swift
//  lydia
//
//  Created by Noeline PAGESY on 04/08/2022.
//

import Combine
import Foundation

protocol ServiceProviderProtocol {
    var users: UserServiceProviderProtocol { get }
    func execute<T: Codable>(route: NetworkRouterProtocol) -> AnyPublisher<T, NetworkError>
}

extension ServiceProviderProtocol {
    
    static var cacheKey: String { "ContactResponse" }
    
    var users: UserServiceProviderProtocol { return UserServiceProvider() }
    
    func execute<T: Codable>(route: NetworkRouterProtocol) -> AnyPublisher<T, NetworkError> {
        guard let request = try? route.asURLRequest() else { return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher() }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    return try retrieveFromCacheOrError(NetworkError.failed) as T
                }
                
                if httpResponse.statusCode == 404 { return try retrieveFromCacheOrError(NetworkError.notFound) as T}
                
                do {
                    let object = try JSONDecoder().decode(T.self, from: data)
                    UserDefaults.standard.set(data, forKey: Self.cacheKey)
                    return object
                } catch {
                    return try retrieveFromCacheOrError(NetworkError.decodeError) as T
                }
            }
            .mapError { error -> NetworkError in
                switch error {
                case let error as NetworkError:
                    print(error.localizedDescription)
                    return error
                case is Swift.DecodingError:
                    print(error.localizedDescription)
                    return NetworkError.decodeError
                default:
                    print(error.localizedDescription)
                    return NetworkError.networkError
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func retrieveFromCacheOrError<T: Codable>(_ error: NetworkError) throws -> T {
        if let data = UserDefaults.standard.object(forKey: Self.cacheKey) as? Data,
           let decodable = try? JSONDecoder().decode(T.self, from: data) {
            return decodable
        } else {
            throw error
        }
    }
}
