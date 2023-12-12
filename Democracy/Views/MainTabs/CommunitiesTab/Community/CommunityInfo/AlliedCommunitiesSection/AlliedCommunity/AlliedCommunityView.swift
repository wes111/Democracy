//
//  AlliedCommunityView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/24/23.
//

import SwiftUI

struct AlliedCommunityView: View {
    
    let viewModel: AlliedCommunityViewModel
    
    var body: some View {
        Text(viewModel.title)
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
    let viewModel = AlliedCommunityViewModel(.preview)
    return AlliedCommunityView(viewModel: viewModel)
}
