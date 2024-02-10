//
//  PhoneTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/5/23.
//

import SwiftUI
import Combine

struct PhoneTextFieldStyle<Field: Hashable>: TextFieldStyle {
    @Binding var phone: String
    @FocusState.Binding var focusedField: Field?
    let field: Field
    
    // swiftlint:disable:next all
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .onReceive(Just(phone)) { input in
                phone = PhoneFormatter.format(with: "(XXX) XXX-XXXX", phone: input)
            }
            .keyboardType(.numberPad)
            .textContentType(.telephoneNumber)
            .standardTextInputAppearance(
                text: $phone,
                focusedField: $focusedField,
                field: field
            )
    }
}

// MARK: - Phone Formatter
enum PhoneFormatter {
    // TODO: Move to a dedicated PhoneFormatter?
    // https://stackoverflow.com/questions/32364055/formatting-phone-number-in-swift
    // mask example: `+X (XXX) XXX-XXXX`
    static func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for char in mask where index < numbers.endIndex {
            if char == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(char) // just append a mask character
            }
        }
        return result
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: CreateAccountFlow?
    
    return ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TextField("Phone", text: .constant("Phone"),
                  prompt: Text("Phone").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(PhoneTextFieldStyle(
            phone: .constant("123-456-7890"),
            focusedField: $focusedField,
            field: CreateAccountFlow.phone
        ))
    }
}
