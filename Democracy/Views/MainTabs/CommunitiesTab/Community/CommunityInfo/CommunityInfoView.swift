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
                
                LeadersSection(viewModel: viewModel.leadershipSectionViewModel)
                
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
