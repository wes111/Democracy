//
//  CustomSecureField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/2/23.
//

import SwiftUI

struct CustomSecureField: View {
    @Binding var secureText: String
    @FocusState.Binding var loginField: LoginField?
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
                .contentShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                .onTapGesture {
                    loginField = .password
                    focusedField = isHidden ? .hidden : .visible
                }
                .limitCharacters(
                    text: $secureText,
                    count: OnboardingInputField.password.maxCharacterCount
                )
            }
            updateVisibilityButton
        }
        .foregroundStyle(Color.primaryText)
        .padding(.horizontal)
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .circular)
                .stroke(Color.tertiaryText, lineWidth: 1.5)
        )
        .onChange(of: loginField) { _, newValue in
            didChangeFromVisibleToHidden = false
            guard newValue == .password else { return }
            focusedField = isHidden ? .hidden : .visible
        }
        .onChange(of: isHidden) { wasHidden, isNowHidden in
            guard loginField == .password else { return }
            didChangeFromVisibleToHidden = !wasHidden && isNowHidden
            focusedField = isHidden ? .hidden : .visible
        }
        .onChange(of: secureText) { visibleText, newHiddenText in
            if didChangeFromVisibleToHidden {
                if newHiddenText.isEmpty { // The user pressed delete.
                    secureText = String(visibleText.dropLast())
                } else { // The user added a new character.
                    secureText = visibleText + newHiddenText
                }
                didChangeFromVisibleToHidden = false
            }
        }
    }
}

// MARK: - SubViews
private extension CustomSecureField {
    
    var unsecureTextField: some View {
        TextField(
            "Enter a password",
            text: $secureText,
            prompt: Text("Password").foregroundColor(.secondaryBackground)
        )
        .opacity(isHidden ? 0.0 : 1.0)
        .focused($focusedField, equals: .visible)
        .padding(.vertical)
    }
    
    var secureTextField: some View {
        SecureField(
            "Enter a password",
            text: $secureText,
            prompt: Text("Password").foregroundColor(.secondaryBackground)
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
    }
    
    enum SecureFocusField {
        case hidden, visible
    }
}

// MARK: - Preview
#Preview {
    
    enum PreviewNameSpace {
        @FocusState static var focus: LoginField?
    }
    
    return ZStack {
        Color.primaryBackground.ignoresSafeArea()
        CustomSecureField(
            secureText: .constant("Hello World"),
            loginField: PreviewNameSpace.$focus
        )
        .padding()
    }
}
