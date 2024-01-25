//
//  CommunityRulesView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI

struct CommunityRulesView: View {
    @Bindable var viewModel: CommunityRulesViewModel
    
    var body: some View {
        EmptyView()
    }
}

// MARK: - Preview
#Preview {
    CommunityRulesView(viewModel: .preview)
}
