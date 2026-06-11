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

        if let token = try? sessionStore.readSessionToken(),
           !token.isEmpty {
            self.state = .loggedIn
        } else {
            self.state = .loggedOut
        }
    }

    func login() {
        try? sessionStore.saveSessionToken("mock-session-token")
        state = .loggedIn
    }

    func logout() {
        try? sessionStore.clearSession()
        state = .loggedOut
    }
}
