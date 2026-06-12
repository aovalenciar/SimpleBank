//
//  SessionStorageTests.swift
//  InterviewBank
//
//  Created by Alan Valencia on 11/06/26.
//

import XCTest
@testable import InterviewBank

final class SessionStoreTests: XCTestCase {

    func test_saveSessionToken_savesTokenInKeychain() throws {
        let keychain = KeychainStorageSpy()
        let sut = SessionStore(keychainStorage: keychain)

        try sut.saveSessionToken("token")

        XCTAssertEqual(keychain.savedValue, "token")
        XCTAssertEqual(keychain.savedKey, "session_token")
    }

    func test_readSessionToken_readsTokenFromKeychain() throws {
        let keychain = KeychainStorageSpy()
        keychain.valueToReturn = "stored-token"
        let sut = SessionStore(keychainStorage: keychain)

        let token = try sut.readSessionToken()

        XCTAssertEqual(token, "stored-token")
        XCTAssertEqual(keychain.readKey, "session_token")
    }

    func test_clearSession_deletesTokenFromKeychain() throws {
        let keychain = KeychainStorageSpy()
        let sut = SessionStore(keychainStorage: keychain)

        try sut.clearSession()

        XCTAssertEqual(keychain.deletedKey, "session_token")
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
