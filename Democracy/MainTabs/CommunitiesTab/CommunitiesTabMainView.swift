//
//  CommunitiesTabMainView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct CommunitiesTabMainView<ViewModel: CommunitiesTabMainViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text("Communities")
    }
}

struct CommunitiesTabMainView_Previews: PreviewProvider {
    static var previews: some View {
        let coordinator = CommunitiesTabCoordinator()
        let viewModel = CommunitiesTabMainViewModel(coordinator: coordinator)
        CommunitiesTabMainView(viewModel: viewModel)
    }
}
