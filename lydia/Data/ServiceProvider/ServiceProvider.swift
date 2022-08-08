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
    func execute<T: Decodable>(route: NetworkRouterProtocol) -> AnyPublisher<T, NetworkError>
    func execute(route: NetworkRouterProtocol, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

extension ServiceProviderProtocol {
    var users: UserServiceProviderProtocol { return UserServiceProvider() }
    
    func execute<T: Decodable>(route: NetworkRouterProtocol) -> AnyPublisher<T, NetworkError> {
        guard let request = try? route.asURLRequest() else { return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher() }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.failed
                }
                
                if httpResponse.statusCode == 404 { throw NetworkError.notFound }
                
                do {
                    let test = try JSONDecoder().decode(T.self, from: data)
                    print(test)
                } catch {
                    print(error)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                switch error {
                case let error as NetworkError:
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
    
    func execute(route: NetworkRouterProtocol, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        if let request = try? route.asURLRequest() {
            URLSession.shared.dataTask(with: request) { data, response, error in

                guard error == nil else {
                    print(error?.localizedDescription ?? NetworkError.networkError.rawValue)
                    completion(.failure(.networkError))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.failed))
                    return
                }

                switch httpResponse.statusCode {
                case 200...299:
                    if let data = data {
                        completion(.success(data))
                    } else {
                        completion(.failure(.failed))
                    }
                default:
                    completion(.failure(.notFound))
                }
            }.resume()
        } else {
            completion(.failure(.invalidURL))
        }
    }
}
