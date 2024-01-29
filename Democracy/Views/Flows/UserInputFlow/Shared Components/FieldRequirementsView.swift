//
//  TextInputRequirements.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/9/24.
//

import SwiftUI

struct FieldRequirementsView<Requirement: InputRequirement>: View {
    let text: String
    let currentInputErrors: [Requirement]
    
    var body: some View {
        VStack(alignment: .leading, spacing: ViewConstants.extraSmallElementSpacing) {
            ForEach(allRequirements, id: \.self) { error in
                if let description = error.descriptionText {
                    if text.isEmpty {
                        requirementLabel(
                            text: description,
                            color: .primaryText,
                            systemImage: SystemImage.asterisk.rawValue
                        )
                    } else if currentInputErrors.contains(error) {
                        requirementLabel(
                            text: description,
                            color: .yellow,
                            systemImage: SystemImage.exclamationmarkTriangle.rawValue
                        )
                    } else {
                        requirementLabel(
                            text: description,
                            color: .green,
                            systemImage: SystemImage.checkmarkCircleFill.rawValue
                        )
                    }
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
    
    var allRequirements: [Requirement] {
        Requirement.allCases as! [Requirement]
    }
}

// MARK: - Preview
#Preview {
    FieldRequirementsView(
        text: "Hello World",
        currentInputErrors: [EmailRequirement.invalidEmail]
    )
}
