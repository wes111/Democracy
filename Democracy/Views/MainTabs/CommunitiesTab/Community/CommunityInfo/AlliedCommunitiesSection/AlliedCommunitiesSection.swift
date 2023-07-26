//
//  AlliedCommunitiesSection.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/24/23.
//

import SwiftUI

struct AlliedCommunitiesSection: View {
    
    let viewModel: AlliedCommunitiesSectionViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            
            Text(viewModel.title)
                .font(.title)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.alliedCommunities) { community in
                        AlliedCommunityView(viewModel: community)
                            .onTapGesture {
                                viewModel.onTapCommunity(id: community.id)
                            }
                            .padding(.leading)
                    }
                }
            }
        }
    }
}

struct AlliedCommunitiesSection_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AlliedCommunitiesSectionViewModel(
            alliedCommunities: Community.myCommunitiesPreviewArray,
            coordinator: CommunityCoordinatorViewModel.preview
        )
        AlliedCommunitiesSection(viewModel: viewModel)
    }
}