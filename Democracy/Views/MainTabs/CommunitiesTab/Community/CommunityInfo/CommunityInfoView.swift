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
                
                AlliedCommunitiesSection(viewModel: viewModel.alliedCommunitiesSectionViewModel)
                
                RulesSection(viewModel: viewModel.rulesSectionViewModel)
                .padding(.horizontal)
                
                ResourcesSection(viewModel: viewModel.resourcesSectionViewModel)
                .padding(.horizontal)
            }
        }
        .foregroundColor(.primaryText)
    }
}

//MARK: - Preview
#Preview {
    CommunityInfoView(viewModel: CommunityInfoViewModel.preview)
        .background(Color.primaryBackground)
}
