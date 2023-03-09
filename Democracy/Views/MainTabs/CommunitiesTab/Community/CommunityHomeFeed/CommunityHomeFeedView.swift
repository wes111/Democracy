//
//  CommunityHomeFeedView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import SwiftUI

struct CommunityHomeFeedView<ViewModel: CommunityHomeFeedViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text("Community Home Feed View")
            .onTapGesture {
                viewModel.goToPost()
            }
    }
}

struct CommunityHomeFeedView_Previews: PreviewProvider {
    static var previews: some View {
        let community = Community(name: "Test Community", foundedDate: Date())
        let router = Router()
        let coordinator = CommunityCoordinator(community, router)
        let viewModel = CommunityHomeFeedViewModel(coordinator: coordinator)
        CommunityHomeFeedView(viewModel: viewModel)
    }
}
