//
//  NetworkRouterTests.swift
//  lydiaTests
//
//  Created by Noeline PAGESY on 04/08/2022.
//

import XCTest

@testable import lydia

class NetworkRouterTests: XCTestCase {

    func test_buildUrlRequest() throws {
        // Given
        let usersCount = 10
        let router = UserRouter.getUsers(count: usersCount)
        
        // When
        let request = try router.asURLRequest().url?.absoluteString
        
        // Then
        XCTAssertEqual(router.urlString, "https://randomuser.me/")
        XCTAssertEqual(router.method, "GET")
        XCTAssertEqual(router.queryItems.first?.name, "results")
        XCTAssertEqual(router.queryItems.first?.value, "\(usersCount)")
        XCTAssertEqual(request, "https://randomuser.me/api/?results=\(usersCount)")
    }
}