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
    
    init(viewModel: CommunityInfoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
            representativesSection
            aboutSection
            rulesSection
            alliedCommunitiesSection
            resourcesSection
                .padding(.horizontal)
        }
        .foregroundColor(.primaryText)
        .padding(.top, ViewConstants.smallElementSpacing)
    }
}

// MARK: - Subviews
private extension CommunityInfoView {
    var aboutSection: some View {
        VStack(alignment: .leading, spacing: ViewConstants.extraLargeElementSpacing) {
            Text("Description")
                .foregroundStyle(Color.primaryText)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal, ViewConstants.screenPadding)
            
            VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                Text(viewModel.description)
                    .font(.caption)
                    .foregroundColor(.secondaryText)
                    .padding(.horizontal, ViewConstants.screenPadding)
                
                Divider()
                    .overlay(Color.black)
            }
        }

    }
    
    var representativesSection: some View {
        VStack(alignment: .leading, spacing: ViewConstants.extraLargeElementSpacing) {
            Text("Representatives")
                .foregroundStyle(Color.primaryText)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal, ViewConstants.screenPadding)
            
            VStack(
                alignment: .leading,
                spacing: ViewConstants.elementSpacing - ViewConstants.smallInnerBorder // Offset for scroll indicator.
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
                
                Divider()
                    .overlay(Color.black)
            }
        }
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
        VStack(alignment: .leading, spacing: ViewConstants.extraLargeElementSpacing) {
            Text("Allied Communities")
                .foregroundStyle(Color.primaryText)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal, ViewConstants.screenPadding)
            
            VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                ForEach(viewModel.alliedCommunities) { community in
                    CommunityCard(viewModel: .init(community: community, coordinator: viewModel.coordinator))
                }
                .padding(.horizontal, ViewConstants.screenPadding)
                
                Divider()
                    .overlay(Color.black)
            }
        }
    }
    
    var rulesSection: some View {
        VStack(alignment: .leading, spacing: ViewConstants.extraLargeElementSpacing) {
            Text("Rules")
                .foregroundStyle(Color.primaryText)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal, ViewConstants.screenPadding)
            
            VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                ForEach(Array(viewModel.rules.enumerated()), id: \.element) { index, rule in
                    ruleView(rule, index: index)
                }
                .padding(.horizontal, ViewConstants.screenPadding)
                
                Divider()
                    .overlay(Color.black)
            }
        }
    }
    
    func ruleView(_ rule: Rule, index: Int) -> some View {
        HStack(alignment: .top, spacing: ViewConstants.smallElementSpacing) {
            Text("\(index)")
                .font(.title2)
                .padding(.trailing, 5)
                .foregroundColor(.tertiaryText)
            
            VStack(alignment: .leading, spacing: ViewConstants.extraSmallElementSpacing) {
                Text(rule.title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                Text(rule.description)
                    .font(.caption2)
                    .foregroundColor(.tertiaryText)
            }
        }
    }
    
    var resourcesSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Resources")
                .font(.title)
            
            ForEach(viewModel.resources, id: \.self) { resource in
                VStack {
                    ResourceView(viewModel: .init(title: resource.title, description: resource.description ?? "", index: 0, url: resource.link))
                    Divider()
                        .overlay(Color.tertiaryBackground)
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ScrollView {
        CommunityInfoView(viewModel: CommunityInfoViewModel.preview)
            .background(Color.primaryBackground)
    }
}
