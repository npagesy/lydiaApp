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
    let postcode: Int
    let coordinates: Coordinates
    let timezone: Timezone
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
    let timezoneDescription: String
}
