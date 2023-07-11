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
                
                AboutSection(viewModel: viewModel.aboutSectionViewModel)
                .padding(.horizontal)
                
                LeadershipSection(viewModel: viewModel.leadershipSectionViewModel)
                
//                AlliedCommunitiesSection(
//                    communities: viewModel.alliedCommunities,
//                    onTapAction: viewModel.onTapCommunityCard
//                )
                
                RulesSection(viewModel: viewModel.rulesSectionViewModel)
                .padding(.horizontal)
                
                ResourcesSection(viewModel: viewModel.resourcesSectionViewModel)
                .padding(.horizontal)
            }
        }
        .foregroundColor(.primaryText)
    }
}

// MARK: - About Section

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

// MARK: - Resources Section

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
