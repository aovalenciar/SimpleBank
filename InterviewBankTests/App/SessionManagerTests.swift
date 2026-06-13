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

    func test_initialState_whenNoStoredTokens_isLoggedOut() {
        let store = SessionStoreSpy()
        let sut = SessionManager(sessionStore: store)

        XCTAssertEqual(sut.state, .loggedOut)
    }

    func test_initialState_whenStoredTokensExist_isLoggedIn() {
        let store = SessionStoreSpy()
        store.tokens = AuthTokens(
            accessToken: "stored-access-token",
            refreshToken: "stored-refresh-token"
        )

        let sut = SessionManager(sessionStore: store)

        XCTAssertEqual(sut.state, .loggedIn)
    }

    func test_saveSession_savesTokensAndUpdatesStateToLoggedIn() {
        let store = SessionStoreSpy()
        let sut = SessionManager(sessionStore: store)

        let tokens = AuthTokens(
            accessToken: "access-token",
            refreshToken: "refresh-token"
        )

        sut.saveSession(tokens: tokens)

        XCTAssertEqual(sut.state, .loggedIn)
        XCTAssertEqual(store.tokens, tokens)
        XCTAssertEqual(store.saveTokensCallCount, 1)
    }

    func test_clearSession_clearsTokensAndUpdatesStateToLoggedOut() {
        let store = SessionStoreSpy()
        let sut = SessionManager(sessionStore: store)

        let tokens = AuthTokens(
            accessToken: "access-token",
            refreshToken: "refresh-token"
        )

        sut.saveSession(tokens: tokens)
        sut.clearSession()

        XCTAssertEqual(sut.state, .loggedOut)
        XCTAssertNil(store.tokens)
        XCTAssertEqual(store.clearSessionCallCount, 1)
    }
}
