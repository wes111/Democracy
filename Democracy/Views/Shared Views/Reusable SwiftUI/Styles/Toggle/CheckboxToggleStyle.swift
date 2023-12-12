//
//  CheckboxToggleStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/18/23.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Button {
                configuration.isOn.toggle()
            } label: {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .font(.title)
                    .foregroundStyle(Color.tertiaryText)
            }
            
            configuration.label
                .font(.callout)
                .foregroundStyle(Color.secondaryText)
        }
        
    }
}

extension ToggleStyle where Self == CheckboxToggleStyle {
    static var iOSCheckbox: CheckboxToggleStyle { .init() }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground
        
        Toggle(isOn: .constant(true)) {
            Text("Toggle Example")
        }
        .toggleStyle(.iOSCheckbox)
    }
    .ignoresSafeArea()

}
