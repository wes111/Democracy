//
//  KeyChainStorage.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/13/23.
//

import AuthenticationServices
import Foundation

struct Credentials {
    let username: String
    let password: String
}

enum KeyChainError: Error {
    case dataError
    case genericError(OSStatus)
}

final class KeyChainStorage {
    
    private static let service = "Democracy.com"
    
    func save(username: String, password: String) throws {
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
        if saveStatus != errSecSuccess {
            print("Error: \(saveStatus)")
        }
    }
    
    func read(username: String) {
        
    }
    
    func delete(username: String) {
        
    }
}
