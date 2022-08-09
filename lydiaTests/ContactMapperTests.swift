//
//  ContactMapperTests.swift
//  lydiaTests
//
//  Created by Noeline PAGESY on 09/08/2022.
//

import XCTest

@testable import lydia

class ContactMapperTests: XCTestCase {
    func test_contactMap() {
        // Given
        let mapper = ContactMapper()
        let user = User(gender: .male,
                        name: Name(title: "M", first: "test", last: "test"),
                        location: Location(street: Street(number: 10, name: "name"),
                                           city: "city",
                                           state: "state",
                                           country: "country",
                                           postcode: Postcode.string("31620"),
                                           coordinates: Coordinates(latitude: "12345678",
                                                                    longitude: "2345678"),
                                           timezone: Timezone(offset: "offset", description: "description")),
                        email: "email",
                        login: Login(uuid: "uuid",
                                     username: "username",
                                     password: "password",
                                     salt: "salt",
                                     md5: "md5",
                                     sha1: "sha1",
                                     sha256: "sha256"),
                        dob: Dob(date: "date", age: 10),
                        registered: Dob(date: "date", age: 10),
                        phone: "phone",
                        cell: "cellphone",
                        id: Id(name: "name", value: "value"),
                        picture: Picture(large: "large", medium: "medium", thumbnail: "thumbnail"),
                        nat: "FR")
        // When
        let contacts = mapper.transformUsersToContacts([user])
        
        // Then
        XCTAssertNotNil(contacts)
        let contact = contacts.first
        XCTAssertNotNil(contact?.loginInformations)
        XCTAssertNotNil(contact?.contactDetails)
        
        XCTAssertEqual(contact?.getidentity(), "\(user.name.last) \(user.name.first)")
    }
}
