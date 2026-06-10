//
//  AuthViewModelTests.swift
//  InterviewBank
//
//  Created by Alan Valencia on 09/06/26.
//

import XCTest
@testable import InterviewBank

@MainActor
final class AuthViewModelTests: XCTestCase {

    func test_loginTapped_updatesSessionToLoggedIn() {
        let sessionManager = SessionManager()

        let sut = AuthViewModel(
            sessionManager: sessionManager
        )

        sut.loginTapped()

        XCTAssertEqual(sessionManager.state, .loggedIn)
    }
}
