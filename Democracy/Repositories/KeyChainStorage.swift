//
//  KeyChainStorage.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/13/23.
//

import AuthenticationServices
import Foundation

enum KeyChainError: Error {
    case dataError
    case genericError(OSStatus)
}

// Note: This actor could be more generic, but that isn't needed currently.
// https://www.swiftdevjournal.com/saving-passwords-in-the-keychain-in-swift/
protocol PasswordRepository {
    func savePassword(username: String, password: String) async throws
    func readPassword(username: String) async throws -> String
    func deletePassword(username: String) async 
    func updatePassword(password: String, username: String) async throws
}

actor PasswordRepositoryDefault: PasswordRepository {
    
    private static let service = "Democracy.com"
    
    init() {
        
    }
    
    func savePassword(username: String, password: String) throws {
        guard let passwordData = password.data(using: .utf8) else {
            throw KeyChainError.dataError
        }
        
        let query = [
            kSecValueData: passwordData,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: Self.service,
            kSecAttrAccount: username
        ] as CFDictionary
        
        let saveStatus = SecItemAdd(query, nil)
     
        guard saveStatus == errSecSuccess else {
            throw KeyChainError.genericError(saveStatus)
        }
    }
    
    func readPassword(username: String) throws -> String {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: Self.service,
            kSecAttrAccount: username,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        guard let data = result as? Data else {
            throw KeyChainError.dataError
        }
        return String(decoding: data, as: UTF8.self)
    }
    
    func deletePassword(username: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: Self.service,
            kSecAttrAccount: username
        ] as CFDictionary
        
        SecItemDelete(query)
    }
    
    func updatePassword(password: String, username: String) throws {
        guard let passwordData = password.data(using: .utf8) else {
            throw KeyChainError.dataError
        }
        
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: Self.service,
            kSecAttrAccount: username
        ] as CFDictionary
            
        let updatedData = [kSecValueData: passwordData] as CFDictionary
        
        let status = SecItemUpdate(query, updatedData)
        
        guard status == errSecSuccess else {
            throw KeyChainError.genericError(status)
        }
    }
}
