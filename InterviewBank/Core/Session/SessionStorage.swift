//
//  SessionStorage.swift
//  InterviewBank
//
//  Created by Alan Valencia on 10/06/26.
//

import Foundation

import Foundation

protocol SessionStoring {
    func saveTokens(_ tokens: AuthTokens) throws
    func readTokens() throws -> AuthTokens?
    func clearSession() throws
}

final class SessionStore: SessionStoring {

    private enum Keys {
        static let authTokens = "auth_tokens"
    }

    private let keychainStorage: KeychainStoring
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init(
        keychainStorage: KeychainStoring = KeychainStorage(),
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.keychainStorage = keychainStorage
        self.encoder = encoder
        self.decoder = decoder
    }

    func saveTokens(_ tokens: AuthTokens) throws {
        let data = try encoder.encode(tokens)
        let value = String(decoding: data, as: UTF8.self)

        try keychainStorage.save(
            value,
            for: Keys.authTokens
        )
    }

    func readTokens() throws -> AuthTokens? {
        guard let value = try keychainStorage.read(for: Keys.authTokens) else {
            return nil
        }

        guard let data = value.data(using: .utf8) else {
            return nil
        }

        return try decoder.decode(AuthTokens.self, from: data)
    }

    func clearSession() throws {
        try keychainStorage.delete(
            for: Keys.authTokens
        )
    }
}
