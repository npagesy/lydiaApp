//
//  User.swift
//  lydia
//
//  Created by Noeline PAGESY on 03/08/2022.
//

import Foundation

struct User: Codable, Equatable {
    let gender: String
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
