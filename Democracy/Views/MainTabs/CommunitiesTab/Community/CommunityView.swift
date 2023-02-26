//
//  CommunityView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import SwiftUI

struct CommunityView<ViewModel: CommunityViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text(viewModel.community.name)
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        let community = Community(name: "Test Community", foundedDate: Date())
        let coordinator = CommunityCoordinator(community)
        let viewModel = CommunityViewModel(coordinator: coordinator, community: community)
        CommunityView(viewModel: viewModel)
    }
}
