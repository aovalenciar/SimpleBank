//
//  AuthModule.swift
//  InterviewBank
//
//  Created by Alan Valencia on 09/06/26.
//

import SwiftUI

enum AuthBuilder {

    @MainActor
    static func build(
        sessionManager: SessionManager
    ) -> some View {
        let repository = MockAuthRepository()

        let useCase = LoginUseCase(
            repository: repository
        )

        let viewModel = AuthViewModel(
            loginUseCase: useCase,
            sessionManager: sessionManager
        )

        return AuthView(
            viewModel: viewModel
        )
    }
}
