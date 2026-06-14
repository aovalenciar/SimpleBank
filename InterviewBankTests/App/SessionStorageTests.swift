//
//  SessionStorageTests.swift
//  InterviewBank
//
//  Created by Alan Valencia on 11/06/26.
//

import XCTest
@testable import InterviewBank

final class SessionStoreTests: XCTestCase {

    func test_saveTokens_savesTokensInKeychain() throws {
        let keychain = KeychainStorageSpy()
        let sut = SessionStore(keychainStorage: keychain)

        let tokens = AuthTokens(
            accessToken: "access-token",
            refreshToken: "refresh-token"
        )

        try sut.saveTokens(tokens)

        XCTAssertNotNil(keychain.savedValue)
        XCTAssertEqual(keychain.savedKey, "auth_tokens")
    }

    func test_readTokens_readsTokensFromKeychain() throws {
        let keychain = KeychainStorageSpy()

        let tokens = AuthTokens(
            accessToken: "access-token",
            refreshToken: "refresh-token"
        )

        let data = try JSONEncoder().encode(tokens)
        keychain.valueToReturn = String(
            decoding: data,
            as: UTF8.self
        )

        let sut = SessionStore(keychainStorage: keychain)

        let result = try sut.readTokens()

        XCTAssertEqual(result, tokens)
        XCTAssertEqual(keychain.readKey, "auth_tokens")
    }

    func test_clearSession_deletesTokensFromKeychain() throws {
        let keychain = KeychainStorageSpy()
        let sut = SessionStore(keychainStorage: keychain)

        try sut.clearSession()

        XCTAssertEqual(keychain.deletedKey, "auth_tokens")
    }
}

private final class KeychainStorageSpy: KeychainStoring {

    var savedValue: String?
    var savedKey: String?
    var readKey: String?
    var deletedKey: String?
    var valueToReturn: String?

    func save(_ value: String, for key: String) throws {
        savedValue = value
        savedKey = key
    }

    func read(for key: String) throws -> String? {
        readKey = key
        return valueToReturn
    }

    func delete(for key: String) throws {
        deletedKey = key
    }
}
