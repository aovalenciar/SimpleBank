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

    func test_initialState_whenNoStoredToken_isLoggedOut() {
        let store = SessionStoreSpy()
        let sut = SessionManager(sessionStore: store)

        XCTAssertEqual(sut.state, .loggedOut)
    }

    func test_initialState_whenStoredTokenExists_isLoggedIn() {
        let store = SessionStoreSpy()
        store.token = "stored-token"

        let sut = SessionManager(sessionStore: store)

        XCTAssertEqual(sut.state, .loggedIn)
    }

    func test_login_updatesStateToLoggedIn() {
        let store = SessionStoreSpy()
        let sut = SessionManager(sessionStore: store)

        sut.login()

        XCTAssertEqual(sut.state, .loggedIn)
        XCTAssertEqual(store.saveSessionTokenCallCount, 1)
    }

    func test_logout_updatesStateToLoggedOut() {
        let store = SessionStoreSpy()
        let sut = SessionManager(sessionStore: store)

        sut.login()
        sut.logout()

        XCTAssertEqual(sut.state, .loggedOut)
        XCTAssertEqual(store.clearSessionCallCount, 1)
    }
}

private final class SessionStoreSpy: SessionStoring {

    var token: String?
    var saveSessionTokenCallCount = 0
    var clearSessionCallCount = 0

    func saveSessionToken(_ token: String) throws {
        saveSessionTokenCallCount += 1
        self.token = token
    }

    func readSessionToken() throws -> String? {
        token
    }

    func clearSession() throws {
        clearSessionCallCount += 1
        token = nil
    }
}
