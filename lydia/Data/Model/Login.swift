//
//  Login.swift
//  lydia
//
//  Created by Noeline PAGESY on 03/08/2022.
//

import Foundation

struct Login: Codable, Equatable {
    let uuid: String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
}
