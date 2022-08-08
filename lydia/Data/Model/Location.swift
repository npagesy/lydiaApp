//
//  Location.swift
//  lydia
//
//  Created by Noeline PAGESY on 03/08/2022.
//

import Foundation

// MARK: - Location
struct Location: Decodable, Equatable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: Postcode
    let coordinates: Coordinates
    let timezone: Timezone
}

// MARK: - Postcode
enum Postcode: Codable, Equatable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Postcode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Coordinates
struct Coordinates: Decodable, Equatable {
    let latitude: String
    let longitude: String
}

// MARK: - Street
struct Street: Decodable, Equatable {
    let number: Int
    let name: String
}

// MARK: - Timezone
struct Timezone: Decodable, Equatable {
    let offset: String
    let description: String
}
