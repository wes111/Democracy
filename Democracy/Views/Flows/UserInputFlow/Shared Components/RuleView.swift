//
//  RuleView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/27/24.
//

import SwiftUI

enum RuleViewSize {
    case small, medium
}

struct RuleView<MenuContent: View>: View {
    @ViewBuilder let menuContent: MenuContent
    let rule: Rule
    let size: RuleViewSize
    
    init(
        rule: Rule,
        size: RuleViewSize = .medium,
        @ViewBuilder menuContent: () -> MenuContent
    ) {
        self.menuContent = menuContent()
        self.rule = rule
        self.size = size
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: ViewConstants.smallElementSpacing) {
            ruleImage
            
            VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
                HStack(alignment: .top, spacing: 0) {
                    ruleTitle
                    Spacer()
                    menuButton
                }
                
                switch size {
                case .small:
                    EmptyView()
                case .medium:
                    ruleDescription
                }
            }
        }
        .frame(height: height, alignment: .top)
        .padding(ViewConstants.innerBorder)
        .background(Color.onBackground, in: RoundedRectangle(cornerRadius: ViewConstants.cornerRadius))
        .foregroundStyle(Color.secondaryText)
    }
    
    var height: CGFloat {
        switch size {
        case .small:
            50
        case .medium:
            125
        }
    }
    
    // Note that padding is added to the image to expand the tappable area of the menu.
    // The padding is then removed from the menu so that the expanded tappable area does not affect
    // the view layout.
    var menuButton: some View {
        let expandedVerticalPadding: CGFloat = 15
        let expandedHorizontalPadding: CGFloat = 10
        
        return Menu {
            menuContent
        } label: {
            Image(systemName: SystemImage.ellipsis.rawValue)
                .font(.system(.title3, weight: .semibold))
                .padding(.horizontal, expandedHorizontalPadding)
                .padding(.vertical, expandedVerticalPadding)
        }
        .padding(.horizontal, -expandedHorizontalPadding)
        .padding(.vertical, -expandedVerticalPadding)
    }
    
    var ruleImage: some View {
        Image(systemName: SystemImage.exclamationmarkTriangleFill.rawValue)
            .font(.system(size: 25))
            .font(.system(.largeTitle, weight: .semibold))
    }
    
    var ruleTitle: some View {
        Text(rule.title)
            .font(.system(.title2, weight: .semibold))
            .lineLimit(1)
    }
    
    var ruleDescription: some View {
        Text(rule.description)
            .foregroundStyle(Color.tertiaryText)
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        RuleView(rule: .init(title: "Rule Title", description: "Rule Description")) {
            EmptyView()
        }
        .padding()
    }
}
