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
        if viewModel.loginStatus == .loggedIn {
            MainTabView(viewModel: viewModel.mainTabViewModel)
        } else {
            RootCoordinatorView(viewModel: viewModel.rootCoordinator)
        }
    }
}

//MARK: - Preview
#Preview {
    let viewModel = RootViewModel()
    return RootView(viewModel: viewModel)
}
