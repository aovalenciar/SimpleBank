//
//  LoginUseCase.swift
//  InterviewBank
//
//  Created by Alan Valencia on 12/06/26.
//

import Foundation

protocol LoginUseCaseProtocol {
    func execute(
        email: String,
        password: String
    ) async throws -> AuthTokens
}

final class LoginUseCase: LoginUseCaseProtocol {

    private let repository: AuthRepositoryProtocol

    init(
        repository: AuthRepositoryProtocol
    ) {
        self.repository = repository
    }

    func execute(
        email: String,
        password: String
    ) async throws -> AuthTokens {
        try await repository.login(
            email: email,
            password: password
        )
    }
}
