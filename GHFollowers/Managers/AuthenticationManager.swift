//
//  AuthenticationManager.swift
//  GHFollowers
//
//  Created by Shuai Zhang on 10/19/23.
//  Copyright © 2023 Simon Zhang. All rights reserved.
//

import Foundation
import Security
//
//let token = "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"

import Security

class AuthenticationManager {
	static let shared: AuthenticationManager = AuthenticationManager()
	private let tokenKey = "com.yourapp.githubPAT"

	// Save the token to the Keychain
	func saveToken(_ token: String) -> Bool {
		// First, delete any existing item with the same key to avoid duplicate entries
		let deleteQuery: [String: Any] = [
			kSecClass as String: kSecClassGenericPassword,
			kSecAttrAccount as String: tokenKey
		]

		SecItemDelete(deleteQuery as CFDictionary)

		// Define the Keychain query
		let query: [String: Any] = [
			kSecClass as String: kSecClassGenericPassword,
			kSecAttrAccount as String: tokenKey,
			kSecValueData as String: token.data(using: .utf8)!,
			kSecAttrDescription as String: "GitHub Personal Access Token" // Optional description
		]

		let status = SecItemAdd(query as CFDictionary, nil)
		return status == errSecSuccess
	}

	// Load the token from the Keychain
	func loadToken() -> String? {
		let query: [String: Any] = [
			kSecClass as String: kSecClassGenericPassword,
			kSecAttrAccount as String: tokenKey,
			kSecReturnData as String: kCFBooleanTrue!,
			kSecMatchLimit as String: kSecMatchLimitOne
		]

		var dataTypeRef: AnyObject?
		let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

		if status == errSecSuccess {
			if let data = dataTypeRef as? Data, let token = String(data: data, encoding: .utf8) {
				return token
			}
		}

		return nil
	}
}
