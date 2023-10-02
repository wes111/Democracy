//
//  AccountService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/28/23.
//

import Combine
import Factory
import Foundation

protocol AccountService {
    func createUser(userName: String, password: String, email: String) async throws
    func getUser() -> User
    
    func isValidUsername(_ userName: String) -> Bool
    func isValidEmail(_ email: String) -> Bool
    func isValidPassword(_ password: String) -> Bool
    
    func getUsernameErrors(_ username: String) -> [UsernameError]
    
    var loginPublisher: AnyPublisher<LoginStatus, Never> { get }
}

final class AccountServiceDefault: AccountService {
    
    @Injected(\.appwriteService) private var appwriteService
    
    private let loginSubject = CurrentValueSubject<LoginStatus, Never>(.loggedOut)
    
    init() {}
    
    static let maxUsernameCharCount = 36 /// Appwrite requirement.
    static let maxPasswordCharCount = 128 /// This is an app requirement, not an Appwrite requirement.
}

extension AccountServiceDefault {
    var loginPublisher: AnyPublisher<LoginStatus, Never> {
        loginSubject.eraseToAnyPublisher()
    }
}

//MARK: Methods
extension AccountServiceDefault {
    
    func createUser(userName: String, password: String, email: String) async throws {
        
    }
    
    func refreshUser() {
        
    }
    
    func updateEmail() {
        
    }
    
    func getUser() -> User {
        return .preview
    }
    
    //MARK: - Validation (TODO: - Move to own class)
    
    func getUsernameErrors(_ username: String) -> [UsernameError] {
        var errors: [UsernameError] = []
        if !isValidUsername(username) {
            if !startsWithAlphanumeric(username) {
                errors.append(.badStartChar)
            }
            if !isValidUsernameLength(username) {
                errors.append(.badLength)
            }
            if !usernameHasValidCharacters(username) {
                errors.append(.invalidChar)
            }
        }
        return errors
    }
    
    private func usernameHasValidCharacters(_ username: String) -> Bool {
        let validRegex = "^[a-zA-Z0-9._-]+$"
        let validTest = NSPredicate(format:"SELF MATCHES %@", validRegex)
        return validTest.evaluate(with: username)
    }
    
    private func startsWithAlphanumeric(_ string: String) -> Bool {
        let alphanumericRegex = "^[a-zA-Z0-9].*"
        let alphanumericTest = NSPredicate(format: "SELF MATCHES %@", alphanumericRegex)
        return alphanumericTest.evaluate(with: string)
    }
    
    private func isValidUsernameLength(_ str: String) -> Bool {
        return (1...36).contains(str.count)
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

enum UsernameError {
    case badLength, badStartChar, invalidChar
    
    var description: String {
        switch self {
        case .badLength:
            "Username must be between 1 and 36 characters long."
        case .badStartChar:
            "Username must start with an alphanumeric character."
        case .invalidChar:
            "Username contains an invalid character."
        }
    }
}
