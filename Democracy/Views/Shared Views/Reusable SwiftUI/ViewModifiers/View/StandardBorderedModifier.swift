//
//  StandardBorderedModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/17/23.
//

import Foundation
import SwiftUI

/// Currently only used for TextFields (and the TaggableModifier).
struct StandardBorderedModifier: ViewModifier {
    let title: String?
    var borderColor: Color
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            if let title {
                Text(title)
                    .font(.callout)
                    .foregroundStyle(Color.secondaryText)
            }
            content
                .foregroundStyle(Color.primaryText)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .circular)
                        .stroke(borderColor, lineWidth: 1.5)
                )
        }
    }
}

extension View {
    
    func standardTextField(title: String? = nil, borderColor: Color = .tertiaryText) -> some View {
        modifier(StandardBorderedModifier(title: title, borderColor: borderColor))
    }
}

enum SecureFocusField {
    case hidden, visible
}

struct CustomSecureField: View {
    @Binding var secureText: String
    @State private var isHidden = true
    @State private var didChangeFromVisibleToHidden = false
    @FocusState.Binding var loginField: LoginField?
    @FocusState private var focusedField: SecureFocusField?
    
    var body: some View {
        HStack {
            ZStack {
                TextField(
                    "Enter a password",
                    text: $secureText,
                    prompt: Text("Password").foregroundColor(.secondaryBackground)
                )
                .opacity(isHidden ? 0.0 : 1.0)
                .padding(.vertical)
                .contentShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                .focused($focusedField, equals: .visible)
                .onTapGesture {
                    loginField = .password
                    focusedField = isHidden ? .hidden : .visible
                }
                
                SecureField(
                    "Enter a password",
                    text: $secureText,
                    prompt: Text("Password").foregroundColor(.secondaryBackground)
                )
                .focused($focusedField, equals: .hidden)
                .limitCharacters(
                    text: $secureText,
                    count: OnboardingInputField.password.maxCharacterCount
                )
                .opacity(isHidden ? 1.0 : 0.0)
                .onTapGesture {
                    loginField = .password
                    focusedField = isHidden ? .hidden : .visible
                }
            }
            Button {
                withAnimation {
                    isHidden.toggle()
                }
            } label: {
                Image(systemName: isHidden ? "eye": "eye.slash")
                    .foregroundStyle(Color.secondaryText)
            }
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
        .onChange(of: secureText) { oldValue, newValue in
            if didChangeFromVisibleToHidden {
                if newValue.isEmpty { // The user pressed delete.
                    secureText = String(oldValue.dropLast())
                } else { // The user added a new character.
                    secureText = oldValue + newValue
                }
                didChangeFromVisibleToHidden = false
            }
        }
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
