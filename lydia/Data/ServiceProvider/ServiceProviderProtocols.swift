//
//  ServiceProviderProtocols.swift
//  lydia
//
//  Created by Noeline PAGESY on 04/08/2022.
//

import Foundation

protocol ServiceProviderProtocol {
    var users: UserServiceProviderProtocol { get }
    func execute(route: NetworkRouterProtocol, completion: @escaping (Result<Data, NetworkError>) -> Void)
}
