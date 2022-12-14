//
//  Contact.swift
//  lydia
//
//  Created by Noeline PAGESY on 03/08/2022.
//

import Foundation

class Contact {
    let id: String
    let gender: Gender?
    let title: String
    let firstName: String
    let lastName: String
    let dateOfBirth: String
    let age: Int
    
    let loginInformations: Informations
    let contactDetails: Details
    
    init(_ user: User) {
        id = user.login.uuid
        gender = Gender(rawValue: user.gender.rawValue)
        title = user.name.title
        firstName = user.name.first
        lastName = user.name.last
        dateOfBirth = user.dob.date
        age = user.dob.age
        
        loginInformations = Informations(user)
        contactDetails = Details(user)
    }
    
    func getidentity() -> String {
        "\(lastName) \(firstName)"
    }
}

class Informations {
    let username: String
    let registeredDate: String
    let registeredAge: Int
    let picture: String
    
    init(_ user: User) {
        username = user.login.username
        registeredDate = user.registered.date
        registeredAge = user.registered.age
        picture = user.picture.large
    }
}

class Details {
    let email: String
    let phone: String
    let cellPhone: String
    let address: Address
    
    init(_ user: User) {
        email = user.email
        phone = user.phone
        cellPhone = user.cell
        address = Address(user.location)
    }
}

class Address {
    let streetNumber: Int
    let streetName: String
    let city: String
    let postCode: String
    
    let latitude: String
    let longitude: String
    
    init(_ location: Location) {
        streetNumber = location.street.number
        streetName = location.street.name
        city = location.city
        
        switch location.postcode {
        case .integer(let codeInt):
            postCode = "\(codeInt)"
        case .string(let codeString):
            postCode = codeString
        }
        
        latitude = location.coordinates.latitude
        longitude = location.coordinates.longitude
    }
}
