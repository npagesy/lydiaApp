//
//  UserServiceProvider.swift
//  lydia
//
//  Created by Noeline PAGESY on 04/08/2022.
//

import Foundation

protocol UserServiceProviderProtocol {
    func getUser(count: Int, completion: @escaping (Result<[User], NetworkError>) -> Void)
}

final class UserServiceProvider: URLSessionServiceProvider, UserServiceProviderProtocol {
    
    func getUser(count: Int = 10, completion: @escaping (Result<[User], NetworkError>) -> Void) {
        execute(route: UserRouter.getUsers(count: count)) { (result: Result<Data, NetworkError>) in
            switch result {
            case .success(let data):
                do {
                    let output = try JSONDecoder().decode([User].self, from: data)
                    completion(.success(output))
                } catch {
                    completion(.failure(.decodeError))
                    return
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
