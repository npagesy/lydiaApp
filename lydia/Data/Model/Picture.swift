//
//  Picture.swift
//  lydia
//
//  Created by Noeline PAGESY on 03/08/2022.
//

import Foundation

struct Picture: Decodable, Equatable {
    let large: String
    let medium: String
    let thumbnail: String
}
