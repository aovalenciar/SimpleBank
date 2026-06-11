//
//  KeychainStorage.swift
//  InterviewBank
//
//  Created by Alan Valencia on 10/06/26.
//

import Foundation
import Security

enum KeychainStorageError: Error {
    case invalidData
    case unexpectedStatus(OSStatus)
}

protocol KeychainStoring {
    func save(_ value: String, for key: String) throws
    func read(for key: String) throws -> String?
    func delete(for key: String) throws
}

final class KeychainStorage: KeychainStoring {

    private let service: String

    init(service: String = Bundle.main.bundleIdentifier ?? "InterviewBank") {
        self.service = service
    }

    func save(_ value: String, for key: String) throws {
        guard let data = value.data(using: .utf8) else {
            throw KeychainStorageError.invalidData
        }

        try delete(for: key)

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        ]

        let status = SecItemAdd(query as CFDictionary, nil)

        guard status == errSecSuccess else {
            throw KeychainStorageError.unexpectedStatus(status)
        }
    }

    func read(for key: String) throws -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        if status == errSecItemNotFound {
            return nil
        }

        guard status == errSecSuccess else {
            throw KeychainStorageError.unexpectedStatus(status)
        }

        guard
            let data = item as? Data,
            let value = String(data: data, encoding: .utf8)
        else {
            throw KeychainStorageError.invalidData
        }

        return value
    }

    func delete(for key: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key
        ]

        let status = SecItemDelete(query as CFDictionary)

        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainStorageError.unexpectedStatus(status)
        }
    }
}
