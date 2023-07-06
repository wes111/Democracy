//
//  CommunityInfoView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import SwiftUI
    
struct CommunityInfoView: View {
    
    @StateObject private var viewModel: CommunityInfoViewModel
    
    init(viewModel: CommunityInfoViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 25) {
                
                AboutSection(
                    summary: viewModel.summary,
                    memberCount: 19515,
                    foundedDateString: "January 5th 2023"
                )
                .padding(.horizontal)
                
                LeadershipSection(viewModel: viewModel.leadershipSectionViewModel)
                
//                AlliedCommunitiesSection(
//                    communities: viewModel.alliedCommunities,
//                    onTapAction: viewModel.onTapCommunityCard
//                )
                
                RulesSection(
                    title: "Rules",
                    rules: viewModel.community.rules
                )
                .padding(.horizontal)
                
                ResourcesSection(
                    title: "Resources",
                    resources: viewModel.community.resources
                )
                .padding(.horizontal)
            }
        }
        .foregroundColor(.primaryText)
    }
}

// MARK: - About Section

struct AboutSection: View {
    
    let summary: String
    let memberCount: Int
    let foundedDateString: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            HStack {
                
                Text("About")
                    .font(.title)
                
                Spacer()
                
                Button {
                    print()
                } label: {
                    Text("Join")
                        .font(.title3)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 3)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.otherRed)
                        )
                }
            }

            HStack(spacing: 10) {
                Text("\(memberCount) Members")
                
                Divider()
                    .overlay(Color.tertiaryText)
                
                Text("Founded \(foundedDateString)")
            }
            .font(.footnote)
                
            Text(summary)
                .font(.caption)
                .foregroundColor(.secondaryText)
        }
    }
}

// MARK: - Representatives Section

struct LeadershipSection: View {
    
    let viewModel: LeadershipSectionViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                
                Text("Representatives")
                    .font(.title)
                
                Spacer()
                
                Button {
                    print()
                } label: {
                    Text("Vote")
                        .font(.title3)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 3)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.otherRed)
                        )
                }
            }
            .padding(.horizontal)

            LeadersScrollView(
                title: viewModel.sectionTitle(repType: .creator),
                candidates: viewModel.creators,
                tapCandidateAction: viewModel.onTapCandidateCard
            )
            
            LeadersScrollView(
                title: viewModel.sectionTitle(repType: .mod),
                candidates: viewModel.mods,
                tapCandidateAction: viewModel.onTapCandidateCard
            )
            
            LeadersScrollView(
                title: viewModel.sectionTitle(repType: .legislator),
                candidates: viewModel.legislators,
                tapCandidateAction: viewModel.onTapCandidateCard
            )
        }
    }
}

struct LeadersScrollView: View {
    
    let title: String
    let candidates: [Candidate]
    let tapCandidateAction: (Candidate) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            Text(title)
                .font(.callout)
                .foregroundColor(.secondaryText)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(candidates, id: \.self) { candidate in
                        CandidateCardView(candidate: candidate)
                            .onTapGesture {
                                tapCandidateAction(candidate)
                            }
                            .padding(.leading)
                    }
                }
            }
        }
    }
}

// MARK: - Rules

struct RulesSection: View {
    
    let title: String
    let rules: [Rule]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title)
            
            ForEach(Array(rules.enumerated()), id: \.element) { index, rule in
                VStack {
                    RuleView(
                        title: rule.title,
                        description: rule.description,
                        index: index
                    )
                    Divider()
                        .overlay(Color.tertiaryBackground)
                }
            }
        }
    }
}

struct RuleView: View {
    
    let title: String
    let description: String
    let index: Int
    
    var body: some View {
        HStack(alignment: .top) {
            Text("\(index)")
                .font(.title2)
                .padding(.trailing, 5)
                .foregroundColor(.tertiaryText)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.bold(.body)())
                Text(description)
                    .font(.caption)
                    .foregroundColor(.tertiaryText)
            }
        }
    }
}

// MARK: - Resources Section

struct ResourcesSection: View {
    
    let title: String
    let resources: [Resource]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title)
            
            ForEach(Array(resources.enumerated()), id: \.element) { index, resource in
                VStack {
                    ResourceView(
                        title: resource.title,
                        description: resource.description,
                        index: index,
                        hyperlink: resource.url)
                    Divider()
                        .overlay(Color.tertiaryBackground)
                }
            }
        }
    }
}

struct ResourceView: View {
    
    let title: String
    let description: String
    let index: Int
    let hyperlink: URL?
    
    var link: String?
    
    init(title: String, description: String, index: Int, hyperlink: URL?) {
        self.title = title
        self.description = description
        self.index = index
        self.hyperlink = hyperlink
        
        if let hyperlink {
            link = "[\(title)](\(hyperlink.absoluteString))"
        }
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Text("\(index)")
                .font(.title2)
                .padding(.trailing, 5)
                .foregroundColor(.tertiaryText)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(.init(link ?? title))
                    .font(.bold(.body)())
                Text(description)
                    .font(.caption)
                    .foregroundColor(.tertiaryText)
            }
        }
    }
}

// MARK: - Allied Communities Section

struct AlliedCommunitiesSection: View {
    
    let communities: [Community]
    let onTapAction: (Community) -> Void
    
    var body: some View {
        
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(communities, id: \.self) { community in
                        CommunityCard(community: community)
                            .onTapGesture {
                                onTapAction(community)
                            }
                            .padding(.leading)
                    }
                }
            }
            
        } header: {
            Text("Allied Communities")
                .font(.title)
                .padding(.horizontal)
            
        }
        .headerProminence(.increased)
    }
}

struct CommunityInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityInfoView(viewModel: CommunityInfoViewModel.preview)
            .background(Color.primaryBackground)
    }
}
