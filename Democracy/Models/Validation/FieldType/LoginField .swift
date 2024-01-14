//
//  LoginField .swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/14/24.
//

import Foundation

enum LoginField {
    case email, password
}

extension LoginField: PasswordCaseRepresentable {
    typealias AlertModel = LoginAlert
    
    var title: String {
        "Todo"
    }
    
    var subtitle: String {
        "Todo"
    }
    
    var fieldTitle: String {
        "Todo"
    }
    
    var required: Bool {
        true
    }
    
    var maxCharacterCount: Int {
        .max
    }
    
    var fullRegex: String {
        ""
    }
    
    var alert: LoginAlert {
        LoginAlert.loginError
    }
    
    var isPasswordCase: Bool {
        switch self {
        case .email:
            false
        case .password:
            true
        }
    }
    
    static var passwordCase: LoginField {
        .password
    }
}
