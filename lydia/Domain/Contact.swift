//
//  Contact.swift
//  lydia
//
//  Created by Noeline PAGESY on 03/08/2022.
//

import Foundation

enum Gender: String, Codable {
    case female
    case male
}

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
        gender = Gender(rawValue: user.gender)
        title = user.name.title
        firstName = user.name.first
        lastName = user.name.last
        dateOfBirth = user.dob.date
        age = user.dob.age
        
        loginInformations = Informations(user)
        contactDetails = Details(user)
    }
}

class Informations {
    var username: String
    let registeredDate: String
    let registeredAge: Int
    var pictures: [String]
    
    init(_ user: User) {
        username = user.login.username
        registeredDate = user.registered.date
        registeredAge = user.registered.age
        pictures = [user.picture.large, user.picture.medium, user.picture.thumbnail]
    }
}

class Details {
    var email: String
    var phone: String
    var cellPhone: String
    
    init(_ user: User) {
        email = user.email
        phone = user.phone
        cellPhone = user.cell
    }
}
