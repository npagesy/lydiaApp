//
//  User.swift
//  lydia
//
//  Created by Noeline PAGESY on 03/08/2022.
//

import Foundation

struct Users: Decodable {
    let results: [User]
    let info: Info
}

struct Info: Codable, Equatable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}

struct User: Decodable, Equatable {
    let gender: Gender
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob: Dob
    let registered: Dob
    let phone: String
    let cell: String
    let id: Id
    let picture: Picture
    let nat: String
}

enum Gender: String, Decodable, Equatable {
    case female = "female"
    case male = "male"
}
