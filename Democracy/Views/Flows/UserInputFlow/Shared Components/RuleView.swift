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
    
    init(
        rule: Rule,
        size: RuleViewSize = .medium,
        @ViewBuilder menuContent: () -> MenuContent
    ) {
        self.menuContent = menuContent()
        self.rule = rule
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
                HStack(alignment: .top, spacing: ViewConstants.smallElementSpacing) {
                    ruleImage
                    ruleTitle
                    Spacer()
                }
                ruleDescription
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
                    .stroke(Color.secondaryText, lineWidth: 1.5)
                    .frame(width: ViewConstants.smallButtonRadius)
                Image(systemName: SystemImage.ellipsis.rawValue)
                    .font(.system(.title3, weight: .semibold))
            }

        }
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
        RuleView(rule: .init(title: "Rule Title", description: "Rule Description Rule Description")) {
            EmptyView()
        }
        .frame(height: 250)
        .padding()
    }
}
