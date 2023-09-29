//
//  AccountService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/28/23.
//

import Factory
import Foundation

protocol AccountService {
    func createUser(userName: String, password: String, email: String) async throws
    func getUser() -> User
    
    func isValidUsername(_ userName: String) -> Bool
    func isValidEmail(_ email: String) -> Bool
    func isValidPassword(_ password: String) -> Bool
}

final class AccountServiceDefault: AccountService {
    
    @Injected(\.appwriteService) private var appwriteService
    
    init() {}
}

extension AccountServiceDefault {
    
    func createUser(userName: String, password: String, email: String) async throws {
        
    }
    
    func getUser() -> User {
        return .preview
    }
    
    //TODO: Could update to return enum cases with invalid reasons.
    func isValidUsername(_ userName: String) -> Bool {
        let regex = "^[a-zA-Z0-9][a-zA-Z0-9._-]{0,35}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: userName)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: email)
    }
    
    /// Requires at least one uppercase letter (A-Z).
    /// Requires at least one lowercase letter (a-z).
    /// Requires at least one digit (0-9).
    /// Requires at least one special character from the provided set: [@, #, $, %, ^, &, +, =, _]
    /// Requires a minimum length of 8 characters.
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@#$%^&+=_])[A-Za-z\\d@#$%^&+=_]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    
}
