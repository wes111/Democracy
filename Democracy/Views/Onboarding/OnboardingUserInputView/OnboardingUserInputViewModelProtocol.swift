//
//  OnboardingUserInputViewModelProtocol.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/14/23.
//

import Factory
import Foundation

//// Validates a type of user input.
//protocol UserInputValidator: Hashable {
//
//    // The complete regex.
//    var fullRegex: String { get }
//
//    // The user's input meets the requirements of the fullRegex.
//    func fullyValid(input: String) -> Bool
//
////    // An array of errors corresponding to individual requirements of the fullRegex.
////    var errors: [any ValidationError] { get }
//}
//
//extension UserInputValidator {
//    func fullyValid(input: String) -> Bool {
//        NSPredicate.validate(string: input, regex: fullRegex)
//    }
//
//    // Returns an array of errors corresponding to the unmet requirements of the fullRegex.
//    func getInputValidationErrors<T: ValidationError>(input: String) -> [T] {
//        var validationErrors: [T] = []
//        if !fullyValid(input: input) {
//            T.allCases.forEach { validation in
//                if !NSPredicate.validate(string: input, regex: validation.regex) {
//                    validationErrors.append(validation)
//                }
//            }
//        }
//        return validationErrors
//    }
//}

protocol OnboardingCoordinatorDelegate: AnyObject {
    func didSubmitUsername()
    func submitPassword()
    func submitEmail()
    func agreeToTerms()
    func continueAccountSetup()
    func submitPhone()
    func submitPhoneVerification()
    func submitEmailVerification()
    
    func close()
    func goBack()
}

enum OnboardingInputField {
    
    case username, password, email, phone, verifyPhone, verifyEmail
    
    func fullyValid(input: String) -> Bool {
        NSPredicate.validate(string: input, regex: fullRegex)
    }
    
    // Returns an array of errors corresponding to the unmet requirements of the fullRegex.
    func getInputValidationErrors<T: ValidationError>(input: String) -> [T] {
        var validationErrors: [T] = []
        if !fullyValid(input: input) {
            T.allCases.forEach { validation in
                if !NSPredicate.validate(string: input, regex: validation.regex) {
                    validationErrors.append(validation)
                }
            }
        }
        return validationErrors
    }
    
    var title: String {
        switch self { 
        case .username:
            "Create Username"
        case .password:
            "Create Password"
        case .email:
            "Create Email"
        case .phone:
            "Create Phone"
        case .verifyPhone:
            "Verify Phone"
        case .verifyEmail:
            "Verify Email"
        }
    }
    
    var subtitle: String {
        switch self { 
        case .username:
            "Create a unique username as a unique identifier across the app."
        case .password:
            "Create a password that will be difficult to guess."
        case .email:
            "Create the primary email for this account"
        case .phone:
            "Create a phone number we can contact you via SMS"
        case .verifyPhone:
            "Enter the code we sent to your phone to verify your phone."
        case .verifyEmail:
            "Enter the code we sent to your email to verify your email."
        }
    }
    
    var fieldTitle: String {
        switch self { 
        case .username:
            "Username"
        case .password:
            "Password"
        case .email:
            "Email"
        case .phone:
            "Phone"
        case .verifyPhone:
            "Phone Code"
        case .verifyEmail:
            "Email Code"
        }
    }
    
    var maxCharacterCount: Int {
        switch self { 
        case .username:
            36 /// Appwrite requirement.
        case .password:
            128 /// Not an Appwrite requirement.
        case .email:
            128
        case .phone:
            10 //TODO: Is this correct
        case .verifyPhone:
            1_000 //TODO: Verify this is long enough
        case .verifyEmail:
            1_000 //TODO: Verify this is long enough
        }
    }
    
    var alertTitle: String {
        switch self { 
        case .username:
            "Invalid username"
        case .password:
            "Invalid password"
        case .email:
            "Invalid email"
        case .phone:
            "Invalid phone number"
        case .verifyPhone:
            "Invalid phone verification code"
        case .verifyEmail:
            "Invalid email verification code"
        }
    }
    
    var alertDescription: String {
        switch self { 
        case .username:
            "Enter a username that matches the requirements."
        case .password:
            "Enter a password that matches the requirements."
        case .email:
            "Enter an email that matches the requirements."
        case .phone:
            "Enter a phone number that matches the requirements."
        case .verifyPhone:
            "Enter a valid phone verification code."
        case .verifyEmail:
            "Enter a valid email verification code."
        }
    }
    
    var fullRegex: String {
        switch self {
        case .username:
            /// Required to start with an alphanumeric character.
            /// Can be followed by up to 35 characters, which can be alphanumeric, dots, underscores, or hyphens.
            "^[a-zA-Z0-9][a-zA-Z0-9._-]{0,35}$"
            
        case .password:
            /// Requires at least one uppercase letter (A-Z).
            /// Requires at least one lowercase letter (a-z).
            /// Requires at least one digit (0-9).
            /// Requires at least one special character from the provided set: [@, #, $, %, ^, &, +, =, _]
            /// At least 8 characters long and at most 128 characters long.
            "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@#$%^&+=_])[A-Za-z\\d@#$%^&+=_]{8,128}$"
            
        case .email:
            /// Local part:
            ///     Must start with a character that is either an uppercase letter (A-Z), lowercase letter (a-z), digit (0-9), percent sign (%), plus sign (+), or hyphen (-).
            ///     Followed by zero or more occurrences of characters that are either uppercase letters (A-Z), lowercase letters (a-z), digits (0-9), dots (.), underscores, percent signs (%), plus signs (+), or hyphens (-).
            /// @ symbol:
            ///     The email address must contain exactly one "@" symbol.
            /// Domain name:
            ///     Must consist of one or more characters.
            ///     Allowed characters are: uppercase letters (A-Z), lowercase letters (a-z), digits (0-9), dots (.), and hyphens (-).
            ///     Dots must not be adjacent to each other.
            /// Dot after Domain:
            ///     The email address must contain exactly one dot (.) after the "@" symbol.
            /// Top-Level Domain (TLD):
            ///     Must consist of at least two characters.
            ///     Allowed characters are: uppercase and lowercase letters (A-Z, a-z).
            "^[A-Z0-9a-z%+-][A-Z0-9a-z._%+-]*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*\\.[A-Za-z]{2,}$"
            
        case .phone:
            /// Must be 10 digits long.
            #"^\d{10}$"#
            
        case .verifyPhone:
            /// String has at least one character, excluding newline.
            #"^.+$"#
            
        case .verifyEmail:
            /// String has at least one character, excluding newline.
            #"^.+$"#
        }
    }
}

protocol ValidatableInputField: Hashable {
    associatedtype Error: ValidationError
    static var field: OnboardingInputField { get }
}

struct EmailValidator: ValidatableInputField {
    typealias Error = EmailValidationError
    static var field: OnboardingInputField = .email
}

struct UsernameValidator: ValidatableInputField {
    typealias Error = UsernameValidationError
    static var field: OnboardingInputField = .username
}

struct PasswordValidator: ValidatableInputField {
    typealias Error = PasswordValidationError
    static var field: OnboardingInputField = .password
}

struct PhoneValidator: ValidatableInputField {
    typealias Error = PhoneValidationError
    static var field: OnboardingInputField = .phone
}

struct VerifyEmailValidator: ValidatableInputField {
    typealias Error = VerifyEmailCodeValidationError
    static var field: OnboardingInputField = .verifyEmail
}

struct VerifyPhoneValidator: ValidatableInputField {
    typealias Error = VerifyPhoneCodeValidationError
    static var field: OnboardingInputField = .verifyPhone
}

class OnboardingUserInputViewModel<T: ValidatableInputField>: Hashable, ObservableObject {
    
    typealias TopButtonsDictionary = [OnboardingTopButton : () -> Void]
    @Published var text: String = ""
    @Published var textErrors: [T.Error] = []
    @Published var onboardingAlert: OnboardingAlert?
    @Injected(\.onboardingFlowService) private var onboardingManager
    
    weak var coordinator: OnboardingCoordinatorDelegate?
    
    init(coordinator: OnboardingCoordinatorDelegate?) {
        self.coordinator = coordinator
        
        setupBindings()
    }
    
    var topButtons: TopButtonsDictionary {
        switch T.field {
        case .username:
            [.close : close]
        case .password:
            [.close: close, .back : goBack]
        case .email:
            [.close: close, .back : goBack]
        case .phone:
            [.close: close]
        case .verifyPhone:
            [.close: close]
        case .verifyEmail:
            [.close: close]
        }
    }
    
    func close() {
        coordinator?.close()
    }
    
    func goBack() {
        coordinator?.goBack()
    }
    
    func submit() {
        do {
            try onboardingManager.submit(input: text, field: T.field)
        } catch {
            presentAlert()
        }
        
        switch T.field {
        case .username:
            coordinator?.didSubmitUsername()
        case .password:
            coordinator?.submitPassword()
        case .email:
            coordinator?.submitEmail()
        case .phone:
            coordinator?.submitPhone()
        case .verifyPhone:
            coordinator?.submitPhoneVerification()
        case .verifyEmail:
            coordinator?.submitEmailVerification()
        }
    }
    
    func resetTextField() async {
        if let text = onboardingManager.getSubmittedValue(field: T.field) {
            await MainActor.run {
                self.text = text
            }
        }
    }
    
    private func presentAlert() {
        Task {
            await MainActor.run {
                self.onboardingAlert = .init(
                    title: T.field.alertTitle,
                    message: T.field.alertDescription
                )
            }
        }
    }
    
    private func setupBindings() {
        $text
            .debounce(for: 0.25, scheduler: RunLoop.main)
            .compactMap { text in
                guard !text.isEmpty else { return [] }
                return T.field.getInputValidationErrors(input: text)
            }
            .assign(to: &$textErrors)
    }
    
    var title: String {
        T.field.title
    }
    
    var subtitle: String {
        T.field.subtitle
    }
    
    var fieldTitle: String {
        T.field.fieldTitle
    }
    
    var maxCharacterCount: Int {
        T.field.maxCharacterCount
    }
    
    var canSubmit: Bool {
        T.field.fullyValid(input: text)
    }
}
