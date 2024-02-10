//
//  SelectableCategory.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/4/24.
//

import SwiftUI

struct SelectableCategory: View {
    var isSelected: Bool
    let title: String
    let subtitle: String?
    let image: SystemImage?
    
    init(
        isSelected: Bool,
        title: String,
        subtitle: String? = nil,
        image: SystemImage? = nil
    ) {
        self.isSelected = isSelected
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
    
    var body: some View {
        HStack(alignment: .center) {
            if let image {
                Image(systemName: image.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 25)
                    .font(.system(.title3, weight: .semibold))
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(.system(.body, weight: .semibold))
                    .foregroundStyle(Color.secondaryText)
                
                if let subtitle {
                    Text(subtitle)
                        .font(.system(.caption, weight: .medium))
                        .foregroundStyle(Color.secondaryText.opacity(0.5))
                }
            }
            
            Spacer()
            
            Image(systemName: SystemImage.checkmarkCircleFill.rawValue)
                .opacity(isSelected ? 1.0 : 0.0)
                
        }
        .categoryModifier()
        .overlay(
            RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
                .strokeBorder(
                    isSelected ? Color.tertiaryText : Color.primaryBackground,
                    lineWidth: ViewConstants.borderWidth
                )
        )
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        VStack(spacing: ViewConstants.elementSpacing) {
            SelectableCategory(isSelected: false, title: "Selectable Category")
            
            SelectableCategory(
                isSelected: true,
                title: "Selectable Category",
                subtitle: "Subtitle",
                image: .exclamationmarkTriangle
            )
            
            SelectableCategory(
                isSelected: true,
                title: "Selectable Category",
                image: .personThree
            )
        }
        .padding()
    }
}
