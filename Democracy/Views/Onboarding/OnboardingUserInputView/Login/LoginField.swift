//
//  LoginField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/28/24.
//

import Foundation

enum LoginField {
    case email, password
}

extension LoginField: PasswordCaseRepresentable {
    var isPasswordCase: Bool {
        switch self {
        case .email:
            false
        case .password:
            true
        }
    }
    
    static var passwordCase: LoginField {
        Self.password
    }
}
