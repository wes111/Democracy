//
//  CommunityInfoView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import SwiftUI
    
struct CommunityInfoView<ViewModel: CommunityInfoViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Button {
            viewModel.showCandidates()
        } label: {
            Text("Show Candidates")
        }

    }
}

struct CommunityInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityInfoView(viewModel: CommunityInfoViewModel.preview)
    }
}
