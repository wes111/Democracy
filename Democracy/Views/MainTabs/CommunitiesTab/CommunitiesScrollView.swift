//
//  CommunityScrollView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/2/23.
//

import SwiftUI

struct CommunitiesScrollView: View {
    
    let title: String
    var communities: [Community]
    let onTapAction: (Community) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.title2)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(communities) { community in
                        CommunityCard(community: community)
                            .padding(.leading)
                            .onTapGesture {
                                onTapAction(community)
                            }
                    }
                }
            }
        }
    }
}


struct CommunitiesScrollView_Previews: PreviewProvider {
    static var previews: some View {
        CommunitiesScrollView(
            title: "Test Communities Scroll View",
            communities: Community.previewArray,
            onTapAction: Community.communityCardTapAction
        )
    }
}
