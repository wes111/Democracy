//
//  VotingTabMainView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct VotingTabMainView<ViewModel: VotingTabMainViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text("Voting")
    }
}

struct VotingTabMainView_Previews: PreviewProvider {
    static var previews: some View {
        VotingTabMainView(viewModel: VotingTabMainViewModel.preview)
    }
}
