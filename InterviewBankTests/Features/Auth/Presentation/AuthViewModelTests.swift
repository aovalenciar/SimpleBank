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

    func test_loginTapped_whenUseCaseSucceeds_savesSession() async {
        let tokens = AuthTokens(
            accessToken: "access-token",
            refreshToken: "refresh-token"
        )

        let useCase = LoginUseCaseStub(
            result: .success(tokens)
        )

        let sessionStore = SessionStoreSpy()

        let sessionManager = SessionManager(
            sessionStore: sessionStore
        )

        let sut = AuthViewModel(
            loginUseCase: useCase,
            sessionManager: sessionManager
        )

        await sut.loginTapped()

        XCTAssertEqual(sut.state, .idle)
        XCTAssertEqual(sessionManager.state, .loggedIn)
        XCTAssertEqual(sessionStore.tokens, tokens)
        XCTAssertEqual(sessionStore.saveTokensCallCount, 1)
    }

    func test_loginTapped_whenUseCaseFails_updatesStateToError() async {
        let useCase = LoginUseCaseStub(
            result: .failure(AnyError.any)
        )

        let sessionStore = SessionStoreSpy()

        let sessionManager = SessionManager(
            sessionStore: sessionStore
        )

        let sut = AuthViewModel(
            loginUseCase: useCase,
            sessionManager: sessionManager
        )

        await sut.loginTapped()

        XCTAssertEqual(
            sut.state,
            .error("No pudimos iniciar sesión. Intenta nuevamente.")
        )

        XCTAssertEqual(sessionManager.state, .loggedOut)
        XCTAssertNil(sessionStore.tokens)
        XCTAssertEqual(sessionStore.saveTokensCallCount, 0)
    }
}

private final class LoginUseCaseStub: LoginUseCaseProtocol {

    private let result: Result<AuthTokens, Error>

    init(
        result: Result<AuthTokens, Error>
    ) {
        self.result = result
    }

    func execute(
        email: String,
        password: String
    ) async throws -> AuthTokens {
        try result.get()
    }
}

private enum AnyError: Error {
    case any
}
