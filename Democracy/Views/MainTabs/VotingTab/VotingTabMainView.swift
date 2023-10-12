//
//  VotingTabMainView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct VotingTabMainView: View {
    
    @StateObject var viewModel: VotingTabMainViewModel
    
    init(viewModel: VotingTabMainViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text("Voting")
    }
}

// MARK: - Preview
#Preview {
    EmptyView()
    //VotingTabMainView(viewModel: VotingTabMainViewModel.preview)
}
