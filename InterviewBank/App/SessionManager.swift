//
//  SessionManager.swift
//  InterviewBank
//
//  Created by Alan Valencia on 09/06/26.
//

import Combine
import Foundation

@MainActor
final class SessionManager: ObservableObject {

    enum State: Equatable {
        case loggedOut
        case loggedIn
    }

    @Published private(set) var state: State

    private let sessionStore: SessionStoring

    init(
        sessionStore: SessionStoring = SessionStore()
    ) {
        self.sessionStore = sessionStore

        if let tokens = try? sessionStore.readTokens(),
           tokens.accessToken.isEmpty == false,
           tokens.refreshToken.isEmpty == false {
            self.state = .loggedIn
        } else {
            self.state = .loggedOut
        }
    }

    func saveSession(tokens: AuthTokens) {
        try? sessionStore.saveTokens(tokens)
        state = .loggedIn
    }

    func clearSession() {
        try? sessionStore.clearSession()
        state = .loggedOut
    }
}
