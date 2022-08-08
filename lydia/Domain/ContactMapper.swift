//
//  ContactMapper.swift
//  lydia
//
//  Created by Noeline PAGESY on 05/08/2022.
//

import Foundation

protocol ContactMapperProtocol {
    func transformUsersToContacts(_ user: [User]) -> [Contact]
}

class ContactMapper: ContactMapperProtocol {
    func transformUsersToContacts(_ users: [User]) -> [Contact] {
        users.map { Contact($0) }
    }
}
