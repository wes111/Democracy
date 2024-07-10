//
//  CommunityInfoView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import SwiftUI

@MainActor
struct CommunityInfoView: View {
    @State private var viewModel: CommunityInfoViewModel
    @Environment(\.openURL) var openURL
    
    init(viewModel: CommunityInfoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
    }
}

// MARK: - Subviews
private extension CommunityInfoView {
    
    var content: some View {
        VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
            representativesSection
            aboutSection
            rulesSection
            alliedCommunitiesSection
            resourcesSection
        }
        .padding(.top, ViewConstants.smallElementSpacing)
    }
    
    var aboutSection: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            Text(viewModel.description)
                .font(.caption)
                .foregroundColor(.secondaryText)
                .padding(.horizontal, ViewConstants.screenPadding)
            
            Divider().overlay(Color.black)
        }
        .sectionModifier(title: "Description")
    }
    
    var representativesSection: some View {
        VStack(
            alignment: .leading,
            // Offset for scroll indicator.
            spacing: ViewConstants.elementSpacing - ViewConstants.smallInnerBorder
        ) {
            ScrollView(.horizontal) {
                HStack(spacing: ViewConstants.elementSpacing) {
                    ForEach(viewModel.candidates) { candidate in
                        representativeCard(candidate)
                    }
                }
                .padding(.bottom, ViewConstants.smallInnerBorder) // Offset for scroll indicator.
            }
            .contentMargins(.horizontal, ViewConstants.screenPadding, for: .scrollContent)
            .contentMargins(.horizontal, ViewConstants.screenPadding, for: .scrollIndicators)
            
            Divider().overlay(Color.black)
        }
        .sectionModifier(title: "Representatives")
    }
    
    func representativeCard(_ rep: Candidate) -> some View {
        VStack(spacing: ViewConstants.smallElementSpacing) {
            Image(rep.imageName ?? "")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 70, height: 70)
                .onTapGesture {
                    viewModel.onTapLeader(id: "")
                }
            
            VStack(spacing: 0) {
                Text(rep.userName)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.tertiaryText)
                    .minimumScaleFactor(0.75)
                    .lineLimit(1)
            }
        }
        .multilineTextAlignment(.center)
        .frame(width: 70)
    }
    
    var alliedCommunitiesSection: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            ForEach(viewModel.alliedCommunities) { community in
                CommunityCard(viewModel: .init(community: community, coordinator: viewModel.coordinator))
            }
            .padding(.horizontal, ViewConstants.screenPadding)
            
            Divider().overlay(Color.black)
        }
        .sectionModifier(title: "Allied Communities")
    }
    
    var rulesSection: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            ForEach(Array(viewModel.rules.enumerated()), id: \.element) { index, rule in
                ruleView(rule, index: index)
            }
            .padding(.horizontal, ViewConstants.screenPadding)
            
            Divider().overlay(Color.black)
        }
        .sectionModifier(title: "Rules")
    }
    
    func ruleView(_ rule: Rule, index: Int) -> some View {
        HStack(alignment: .top, spacing: ViewConstants.smallElementSpacing) {
            Text("\(index)")
                .font(.title2)
                .padding(.trailing, 5)
                .foregroundColor(.tertiaryText)
            
            VStack(alignment: .leading, spacing: ViewConstants.extraSmallElementSpacing) {
                Text(rule.title)
                    .foregroundStyle(Color.primaryText)
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                Text(rule.description)
                    .font(.caption2)
                    .foregroundColor(.tertiaryText)
            }
        }
    }
    
    func resourceView(_ resource: Resource) -> some View {
        Button {
            if let resourceLink = resource.link {
                openURL(resourceLink)
            }
        } label: {
            VStack(alignment: .leading, spacing: ViewConstants.extraSmallElementSpacing) {
                HStack(alignment: .center, spacing: ViewConstants.smallElementSpacing) {
                    Image(systemName: resource.category.image.rawValue)
                    
                    Text(resource.title)
                        .foregroundStyle(Color.primaryText)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                HStack(alignment: .lastTextBaseline, spacing: ViewConstants.smallElementSpacing) {
                    if let description = resource.description {
                        Text(description)
                            .font(.caption2)
                            .foregroundColor(.tertiaryText)
                    }
                    
                    if resource.link != nil {
                        Image(systemName: SystemImage.arrowUpRightSquare.rawValue)
                            .foregroundStyle(Color.primaryText)
                    }
                }
            }
            .multilineTextAlignment(.leading)
            .padding(ViewConstants.smallInnerBorder)
            .background(
                Color.secondaryBackground,
                in: RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
            )
        }
    }
    
    var resourcesSection: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            ForEach(viewModel.resources) { resource in
                resourceView(resource)
            }
            .padding(.horizontal, ViewConstants.screenPadding)
            
            Divider().overlay(Color.black)
        }
        .sectionModifier(title: "Resources")
    }
}

// MARK: Helper ViewModifier

struct SectionModifier: ViewModifier {
    let title: String
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: ViewConstants.extraLargeElementSpacing) {
            Text(title)
                .foregroundStyle(Color.primaryText)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal, ViewConstants.screenPadding)
            
            content
        }
    }
}

extension View {
    func sectionModifier(title: String) -> some View {
        self.modifier(SectionModifier(title: title))
    }
}

// MARK: - Preview
#Preview {
    ScrollView {
        CommunityInfoView(viewModel: CommunityInfoViewModel.preview)
            .background(Color.primaryBackground)
    }
}
