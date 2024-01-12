//
//  TextInputRequirements.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/9/24.
//

import SwiftUI

struct FieldRequirementsView<Requirement: InputRequirement>: View {
    let allPossibleErrors: [Requirement]
    let text: String
    let currentInputErrors: [Requirement]
    
    var body: some View {
        VStack(alignment: .leading, spacing: ViewConstants.extraSmallElementSpacing) {
            ForEach(allPossibleErrors, id: \.self) { error in
                if text.isEmpty {
                    requirementLabel(
                        text: error.descriptionText,
                        color: .primaryText,
                        systemImage: SystemImage.asterisk.rawValue
                    )
                } else if currentInputErrors.contains(error) {
                    requirementLabel(
                        text: error.descriptionText,
                        color: .yellow,
                        systemImage: SystemImage.exclamationmarkTriangle.rawValue
                    )
                } else {
                    requirementLabel(
                        text: error.descriptionText,
                        color: .green,
                        systemImage: SystemImage.checkmarkCircleFill.rawValue
                    )
                }
            }
            .foregroundColor(.tertiaryText)
        }
    }
    
    func requirementLabel(text: String, color: Color, systemImage: String) -> some View {
        Label {
            Text(text)
        } icon: {
            Image(systemName: systemImage)
                .foregroundColor(color)
                .frame(width: 10, height: 10)
        }
        .font(.system(.caption, weight: .light))
    }
}

// MARK: - Preview
#Preview {
    FieldRequirementsView<UsernameRequirement>(
        allPossibleErrors: [UsernameValidator.Requirement.length],
        text: "Hello World",
        currentInputErrors: [UsernameValidator.Requirement.length])
}
