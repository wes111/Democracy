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
    
    private let isSmall: Bool
    
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
        
        isSmall = subtitle == nil
    }
    
    var body: some View {
        HStack(alignment: .center) {
            if let image {
                Image(systemName: image.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 25)
                    .font(.system(.title3, weight: .semibold))
                    .foregroundStyle(colorScheme.secondaryText)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(isSmall ? .footnote : .body)
                    .fontWeight(.semibold)
                    .foregroundStyle(colorScheme.secondaryText)
                
                if let subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(colorScheme.secondaryText.opacity(0.5))
                }
            }
            
            Spacer()
            
            Image(systemName: SystemImage.checkmarkCircleFill.rawValue)
                .font(isSmall ? .footnote : .body)
                .opacity(isSelected ? 1.0 : 0.0)
                .foregroundStyle(Color.green)
                
        }
        .padding(ViewConstants.innerBorder)
        .background(
            colorScheme.onBackground,
            in: RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
        )
        .overlay(
            RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
                .strokeBorder(
                    isSelected ? colorScheme.tertiaryText : .clear,
                    lineWidth: isSmall ? ViewConstants.thinBorderWidth : ViewConstants.borderWidth
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
                image: nil
            )
        }
        .padding()
    }
}
