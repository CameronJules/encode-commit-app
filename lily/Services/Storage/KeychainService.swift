//
//  KeychainService.swift
//  lily
//
//  Created by Cameron Jules on 06/02/2026.
//

import Foundation
import Security

// MARK: - Keychain Key

enum KeychainKey: String {
    case accessToken = "com.lily.accessToken"
    case refreshToken = "com.lily.refreshToken"
}

// MARK: - Keychain Error

enum KeychainError: LocalizedError {
    case saveFailed(OSStatus)
    case deleteFailed(OSStatus)
    case unexpectedData

    var errorDescription: String? {
        switch self {
        case .saveFailed(let status):
            return "Keychain save failed with status: \(status)"
        case .deleteFailed(let status):
            return "Keychain delete failed with status: \(status)"
        case .unexpectedData:
            return "Unexpected keychain data format"
        }
    }
}

// MARK: - Keychain Service

struct KeychainService {

    func save(_ value: String, for key: KeychainKey) throws {
        guard let data = value.data(using: .utf8) else {
            throw KeychainError.unexpectedData
        }

        // Delete existing item first
        try? delete(for: key)

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock,
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError.saveFailed(status)
        }
    }

    func retrieve(for key: KeychainKey) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne,
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess, let data = result as? Data else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func delete(for key: KeychainKey) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
        ]

        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.deleteFailed(status)
        }
    }

    func deleteAll() {
        try? delete(for: .accessToken)
        try? delete(for: .refreshToken)
    }
}
