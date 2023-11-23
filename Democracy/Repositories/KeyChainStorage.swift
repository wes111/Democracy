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

final class KeyChainStorage {
    
    private static let service = "Democracy.com"
    
    func save(username: String, password: String) {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: Self.service,
            kSecAttrAccount: username
        ] as CFDictionary
    }
    
    func read(username: String) {
        
    }
    
    func delete(username: String) {
        
    }
}
