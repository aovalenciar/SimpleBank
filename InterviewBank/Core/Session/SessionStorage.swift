//
//  SessionStorage.swift
//  InterviewBank
//
//  Created by Alan Valencia on 10/06/26.
//

import Foundation

protocol SessionStoring {
    func saveSessionToken(_ token: String) throws
    func readSessionToken() throws -> String?
    func clearSession() throws
}

final class SessionStore: SessionStoring {

    private enum Keys {
        static let sessionToken = "session_token"
    }

    private let keychainStorage: KeychainStoring

    init(
        keychainStorage: KeychainStoring = KeychainStorage()
    ) {
        self.keychainStorage = keychainStorage
    }

    func saveSessionToken(_ token: String) throws {
        try keychainStorage.save(
            token,
            for: Keys.sessionToken
        )
    }

    func readSessionToken() throws -> String? {
        try keychainStorage.read(
            for: Keys.sessionToken
        )
    }

    func clearSession() throws {
        try keychainStorage.delete(
            for: Keys.sessionToken
        )
    }
}
