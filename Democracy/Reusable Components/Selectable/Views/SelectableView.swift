//
//  SelectableCategory.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/4/24.
//

import SwiftUI

struct SelectableView: View {
    var isSelected: Bool
    let title: String
    let subtitle: String?
    let image: SystemImage?
    let colorScheme: ColorScheme
    
    init(
        isSelected: Bool,
        title: String,
        subtitle: String? = nil,
        image: SystemImage? = nil,
        colorScheme: ColorScheme = .init()
    ) {
        self.isSelected = isSelected
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.colorScheme = colorScheme
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
                    .foregroundStyle(colorScheme.secondaryText)
                
                if let subtitle {
                    Text(subtitle)
                        .font(.system(.caption, weight: .medium))
                        .foregroundStyle(colorScheme.secondaryText.opacity(0.5))
                }
            }
            
            Spacer()
            
            Image(systemName: SystemImage.checkmarkCircleFill.rawValue)
                .opacity(isSelected ? 1.0 : 0.0)
                
        }
        .selectableModifier(colorScheme: colorScheme)
        .overlay(
            RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
                .strokeBorder(
                    isSelected ? colorScheme.tertiaryText : .clear, // colorScheme.primaryBackground,
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
            SelectableView(isSelected: false, title: "Selectable Category")
            
            SelectableView(
                isSelected: true,
                title: "Selectable Category",
                subtitle: "Subtitle",
                image: .exclamationmarkTriangle
            )
            
            SelectableView(
                isSelected: true,
                title: "Selectable Category",
                image: .personThree
            )
        }
        .padding()
    }
}
