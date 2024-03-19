//
//  RuleView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/27/24.
//

import SwiftUI

struct MenuCard<MenuContent: View>: View {
    @ViewBuilder let menuContent: MenuContent
    let title: String
    let description: String?
    let image: SystemImage
    
    init(
        title: String,
        description: String?,
        image: SystemImage,
        @ViewBuilder menuContent: () -> MenuContent
    ) {
        self.title = title
        self.description = description
        self.image = image
        self.menuContent = menuContent()
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
                HStack(alignment: .top, spacing: ViewConstants.smallElementSpacing) {
                    formattedImage
                    formattedTitle
                    Spacer()
                }
                formattedDescription
            }
            .padding(ViewConstants.innerBorder)
            
            menuButton
                .padding(ViewConstants.smallInnerBorder)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color.onBackground, in: RoundedRectangle(cornerRadius: ViewConstants.cornerRadius))
        .foregroundStyle(Color.secondaryText)
    }
    
    var menuButton: some View {
        Menu {
            menuContent
        } label: {
            ZStack {
                Circle()
                    .stroke(Color.tertiaryText, lineWidth: 1.5)
                    .frame(width: ViewConstants.smallButtonRadius)
                Image(systemName: SystemImage.ellipsis.rawValue)
                    .font(.system(.title3, weight: .semibold))
            }

        }
    }
    
    var formattedImage: some View {
        Image(systemName: image.rawValue)
            .font(.system(size: 25))
            .font(.system(.largeTitle, weight: .semibold))
    }
    
    var formattedTitle: some View {
        Text(title)
            .font(.system(.title2, weight: .semibold))
            .lineLimit(1)
    }
    
    var formattedDescription: some View {
        Text(description ?? "")
            .foregroundStyle(Color.tertiaryText)
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        MenuCard(
            title: "Menu Card Title",
            description: "Menu Card Description",
            image: .exclamationmarkTriangle
        ) {
            EmptyView()
        }
        .frame(height: 250)
        .padding()
    }
}
