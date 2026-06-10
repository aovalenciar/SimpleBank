//
//  AuthViewModel.swift
//  InterviewBank
//
//  Created by Alan Valencia on 09/06/26.
//

import Combine

@MainActor
final class AuthViewModel: ObservableObject {

    private let sessionManager: SessionManager

    init(
        sessionManager: SessionManager
    ) {
        self.sessionManager = sessionManager
    }

    func loginTapped() {
        sessionManager.login()
    }
}
