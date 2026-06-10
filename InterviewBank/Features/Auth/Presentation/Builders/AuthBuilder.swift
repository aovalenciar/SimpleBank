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
        let viewModel = AuthViewModel(
            sessionManager: sessionManager
        )

        return AuthView(
            viewModel: viewModel
        )
    }
}
