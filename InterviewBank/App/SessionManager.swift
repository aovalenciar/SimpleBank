//
//  SessionManager.swift
//  InterviewBank
//
//  Created by Alan Valencia on 09/06/26.
//

import Combine

@MainActor
final class SessionManager: ObservableObject {

    enum State {
        case loggedOut
        case loggedIn
    }

    @Published private(set) var state: State = .loggedOut

    func login() {
        state = .loggedIn
    }

    func logout() {
        state = .loggedOut
    }
}
