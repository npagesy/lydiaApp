//
//  ContactMapper.swift
//  lydia
//
//  Created by Noeline PAGESY on 05/08/2022.
//

import Foundation

class ContactMapper {
    func transformUsersToContacts(_ users: [User]) -> [Contact] {
        users.map { Contact($0) }
    }
}
