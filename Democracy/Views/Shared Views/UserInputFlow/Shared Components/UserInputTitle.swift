//
//  UserInputTitle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/9/24.
//

import SwiftUI

struct UserInputTitle: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.system(.title, weight: .semibold))
            .foregroundColor(.primaryText)
    }
}

// MARK: - Preview
#Preview {
    UserInputTitle(title: "Hello World")
}
