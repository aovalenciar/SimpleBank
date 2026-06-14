//
//  AuthViewModel.swift
//  InterviewBank
//
//  Created by Alan Valencia on 09/06/26.
//

import Combine
import Foundation

@MainActor
final class AuthViewModel: ObservableObject {

    enum State: Equatable {
        case idle
        case loading
        case error(String)
    }

    @Published private(set) var state: State = .idle

    private let loginUseCase: LoginUseCaseProtocol
    private let sessionManager: SessionManager

    init(
        loginUseCase: LoginUseCaseProtocol,
        sessionManager: SessionManager
    ) {
        self.loginUseCase = loginUseCase
        self.sessionManager = sessionManager
    }

    func loginTapped() async {
        state = .loading

        do {
            let tokens = try await loginUseCase.execute(
                email: "alan@test.com",
                password: "password"
            )

            sessionManager.saveSession(tokens: tokens)
            state = .idle

        } catch {
            state = .error("No pudimos iniciar sesión. Intenta nuevamente.")
        }
    }
}
