//
//  LoginUseCaseTests.swift
//  InterviewBank
//
//  Created by Alan Valencia on 13/06/26.
//

import XCTest
@testable import InterviewBank

final class LoginUseCaseTests: XCTestCase {

    func test_execute_whenRepositorySucceeds_returnsTokens() async throws {
        let tokens = AuthTokens(
            accessToken: "access-token",
            refreshToken: "refresh-token"
        )

        let repository = AuthRepositoryStub(
            result: .success(tokens)
        )

        let sut = LoginUseCase(
            repository: repository
        )

        let result = try await sut.execute(
            email: "alan@test.com",
            password: "password"
        )

        XCTAssertEqual(result, tokens)
    }

    func test_execute_whenRepositoryFails_throwsError() async {
        let repository = AuthRepositoryStub(
            result: .failure(AnyError.any)
        )

        let sut = LoginUseCase(
            repository: repository
        )

        do {
            _ = try await sut.execute(
                email: "alan@test.com",
                password: "password"
            )

            XCTFail("Expected error to be thrown")

        } catch {
            XCTAssertEqual(error as? AnyError, .any)
        }
    }
}

private final class AuthRepositoryStub: AuthRepositoryProtocol {

    private let result: Result<AuthTokens, Error>

    init(
        result: Result<AuthTokens, Error>
    ) {
        self.result = result
    }

    func login(
        email: String,
        password: String
    ) async throws -> AuthTokens {
        try result.get()
    }
}

private enum AnyError: Error {
    case any
}
