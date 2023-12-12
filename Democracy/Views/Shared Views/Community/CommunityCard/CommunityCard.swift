//
//  CommunityCard.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/2/23.
//

import SwiftUI

struct CommunityCard: View {
    
    let community: Community
    
    var body: some View {
        Text(community.name)
            .frame(width: 150, height: 100, alignment: .center)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.red)
            )
    }
}

// MARK: - Preview
#Preview {
    CommunityCard(community: Community.preview)
}
