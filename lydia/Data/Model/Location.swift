//
//  Location.swift
//  lydia
//
//  Created by Noeline PAGESY on 03/08/2022.
//

import Foundation

// MARK: - Location
struct Location: Codable, Equatable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: Int
    let coordinates: Coordinates
    let timezone: Timezone
}

// MARK: - Coordinates
struct Coordinates: Codable, Equatable {
    let latitude: String
    let longitude: String
}

// MARK: - Street
struct Street: Codable, Equatable {
    let number: Int
    let name: String
}

// MARK: - Timezone
struct Timezone: Codable, Equatable {
    let offset: String
    let timezoneDescription: String
}
