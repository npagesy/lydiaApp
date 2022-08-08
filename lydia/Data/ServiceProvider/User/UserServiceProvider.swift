//
//  UserServiceProvider.swift
//  lydia
//
//  Created by Noeline PAGESY on 04/08/2022.
//

import Combine
import Foundation

protocol UserServiceProviderProtocol {
    func getUsers(count: Int, page: Int?) -> AnyPublisher<Users, NetworkError>
}

final class UserServiceProvider: ServiceProviderProtocol, UserServiceProviderProtocol {
    func getUsers(count: Int = 10, page: Int? = 1) -> AnyPublisher<Users, NetworkError> {
        execute(route: UserRouter.getUsers(count: count, page: page))
    }
}
