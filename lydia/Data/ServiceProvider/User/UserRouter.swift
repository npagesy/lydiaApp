//
//  UserRouter.swift
//  lydia
//
//  Created by Noeline PAGESY on 04/08/2022.
//

import Foundation

enum UserRouter: NetworkRouterProtocol {
    case getUsers(count: Int)

    var urlString: String { "https://randomuser.me/" }
    var method: String { "GET" }
    var path: String { "api/" }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getUsers(let count):
            return [URLQueryItem(name: "results", value: "\(count)")]
        }
    }
}
