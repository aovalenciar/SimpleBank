//
//  MockAuthRepository.swift
//  InterviewBank
//
//  Created by Alan Valencia on 12/06/26.
//

import Foundation

final class MockAuthRepository: AuthRepositoryProtocol {

    func login(
        email: String,
        password: String
    ) async throws -> AuthTokens {
        try await Task.sleep(nanoseconds: 500_000_000)

        return AuthTokens(
            accessToken: "mock-access-token",
            refreshToken: "mock-refresh-token"
        )
    }
}
