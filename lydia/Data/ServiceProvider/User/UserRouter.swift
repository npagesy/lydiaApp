//
//  UserRouter.swift
//  lydia
//
//  Created by Noeline PAGESY on 04/08/2022.
//

import Foundation

enum UserRouter: NetworkRouterProtocol {
    case getUsers(count: Int, page: Int?)

    var urlString: String { "https://randomuser.me/" }
    var method: String { "GET" }
    var path: String { "api/" }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getUsers(let count, let page):
            var queryItems: [URLQueryItem] = []
            queryItems.append(URLQueryItem(name: "results", value: "\(count)"))
            if let page = page {
                queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
            }
            return queryItems
        }
    }
}
