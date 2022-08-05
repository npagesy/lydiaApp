//
//  URLSessionServiceProvider.swift
//  lydia
//
//  Created by Noeline PAGESY on 04/08/2022.
//

import Foundation

class URLSessionServiceProvider: ServiceProviderProtocol {
    var users: UserServiceProviderProtocol { return UserServiceProvider() }
    
    private let session: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.session = urlSession
    }
    
    func execute(route: NetworkRouterProtocol, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        if let request = try? route.asURLRequest() {
            session.dataTask(with: request) { data, response, error in
                
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
