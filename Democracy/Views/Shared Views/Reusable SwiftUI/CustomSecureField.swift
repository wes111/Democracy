//
//  CustomSecureField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/2/23.
//

import SwiftUI

protocol PasswordCaseRepresentable: Hashable {
    var isPasswordCase: Bool { get }
    static var passwordCase: Self { get }
}

struct CustomSecureField<T: PasswordCaseRepresentable>: View {
    @Binding var secureText: String
    @FocusState.Binding var loginField: T?
    @FocusState private var focusedField: SecureFocusField?
    @State private var isHidden = true
    @State private var didChangeFromVisibleToHidden = false
    
    var body: some View {
        HStack {
            ZStack {
                Group {
                    unsecureTextField
                    secureTextField
                }
                .textFieldStyle(PasswordTextFieldStyle(
                    password: $secureText,
                    isNewPassword: false)
                )
                .onTapGesture {
                    loginField = T.passwordCase
                    focusedField = isHidden ? .hidden : .visible
                }
            }
            updateVisibilityButton
        }
        // Prevent button from bouncing incorrectly on keyboard dismiss.
        .geometryGroup()
        .padding(.horizontal)
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
        .onChange(of: loginField) { _, newValue in
            didChangeFromVisibleToHidden = false
            guard let newValue, newValue.isPasswordCase else { return }
            focusedField = isHidden ? .hidden : .visible
        }
        .onChange(of: isHidden) { wasHidden, isNowHidden in
            guard let loginField, loginField.isPasswordCase else { return }
            didChangeFromVisibleToHidden = !wasHidden && isNowHidden
            focusedField = isHidden ? .hidden : .visible
        }
        .onChange(of: secureText) { visibleText, newHiddenText in
            secureTextDidChange(
                visibleText: visibleText,
                newHiddenText: newHiddenText
            )
        }
    }
}

// MARK: - SubViews
private extension CustomSecureField {
    
    var unsecureTextField: some View {
        TextField(
            "Enter a password",
            text: $secureText,
            prompt: Text("Password").foregroundColor(.tertiaryBackground)
        )
        .disabled(isHidden)
        .opacity(isHidden ? 0.0 : 1.0)
        .focused($focusedField, equals: .visible)
    }
    
    var secureTextField: some View {
        SecureField(
            "Enter a password",
            text: $secureText,
            prompt: Text("Password").foregroundColor(.tertiaryBackground)
        )
        .opacity(isHidden ? 1.0 : 0.0)
        .focused($focusedField, equals: .hidden)
    }
    
    var updateVisibilityButton: some View {
        Button {
            withAnimation {
                isHidden.toggle()
            }
        } label: {
            Image(systemName: isHidden ? "eye": "eye.slash")
                .foregroundStyle(Color.secondaryText)
        }
        .foregroundStyle(Color.primaryText)
    }
}

// MARK: Private Methods
private extension CustomSecureField {
    
    func secureTextDidChange(visibleText: String, newHiddenText: String) {
        if didChangeFromVisibleToHidden {
            if newHiddenText.isEmpty { // The user pressed delete.
                secureText = String(visibleText.dropLast())
            } else if newHiddenText.count == 1 { // The user added a new character.
                secureText = visibleText + newHiddenText
            } else {
                // 'onChange' is in a bad state, so set the text to an emtpy string.
                secureText = ""
                // TODO: Remove! For debugging only!
                fatalError("original: \(visibleText), new: \(newHiddenText))")
            }
            didChangeFromVisibleToHidden = false
        }
    }
}

// MARK: - Private Helper Objects
private extension CustomSecureField {
    enum SecureFocusField {
        case hidden, visible
    }
}

// MARK: - Preview
//#Preview {
//    
//    enum PreviewNameSpace {
//        @FocusState static var focus: LoginField?
//    }
//    
//    return ZStack {
//        Color.primaryBackground.ignoresSafeArea()
//        CustomSecureField(
//            secureText: .constant("Hello World"),
//            loginField: PreviewNameSpace.$focus
//        )
//        .padding()
//    }
//}
