//
//  SessionManagerTests.swift
//  InterviewBank
//
//  Created by Alan Valencia on 09/06/26.
//

import XCTest
@testable import InterviewBank

@MainActor
final class SessionManagerTests: XCTestCase {

    func test_initialState_isLoggedOut() {
        let sut = SessionManager()

        XCTAssertEqual(sut.state, .loggedOut)
    }

    func test_login_updatesStateToLoggedIn() {
        let sut = SessionManager()

        sut.login()

        XCTAssertEqual(sut.state, .loggedIn)
    }

    func test_logout_updatesStateToLoggedOut() {
        let sut = SessionManager()

        sut.login()
        sut.logout()

        XCTAssertEqual(sut.state, .loggedOut)
    }
}
