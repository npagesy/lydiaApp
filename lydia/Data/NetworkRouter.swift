//
//  NetworkRouter.swift
//  lydia
//
//  Created by Noeline PAGESY on 04/08/2022.
//

import Foundation

protocol NetworkRouterProtocol {
    var urlString: String { get }
    var method: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension NetworkRouterProtocol {
    func asURLRequest() throws -> URLRequest {
        guard var urlComponents = URLComponents(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        if !path.isEmpty { urlComponents.path += path }
        urlComponents.queryItems = queryItems
        if let url = urlComponents.url {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method
            return urlRequest
        } else {
            throw NetworkError.invalidURL
        }
    }
}
