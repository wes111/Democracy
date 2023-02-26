//
//  RootView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct RootView<ViewModel: RootViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if viewModel.isAuthenticated {
            MainTabView()
        } else {
            AuthenticationCoordinator()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RootViewModel()
        RootView(viewModel: viewModel)
    }
}
