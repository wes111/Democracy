//
//  RootView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct RootView: View {
    
    @StateObject var viewModel: RootViewModel
    
    init(viewModel: RootViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if viewModel.isAuthenticated {
            MainTabView(viewModel: viewModel.mainTabViewModel)
        } else {
            AuthenticationCoordinator(viewModel: viewModel.authenticationCoordinatorViewModel)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RootViewModel()
        RootView(viewModel: viewModel)
    }
}
