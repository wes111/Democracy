//
//  UpdatesTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct UpdatesTabCoordinator: View {
    
    @StateObject private var viewModel: UpdatesTabCoordinatorViewModel
    
    init(viewModel: UpdatesTabCoordinatorViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        CoordinatorView(router: $viewModel.router) {
            UpdatesTabMainView(viewModel: viewModel.updatesTabMainViewModel())
        } secondaryScreen: { (path: UpdatesTabPath) in
            createViewFromPath(path)
        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: UpdatesTabPath) -> some View {
        switch path {
        case .one:
            EmptyView()
        }
    }
    
    func createUpdatesTabMainView() -> UpdatesTabMainView<UpdatesTabMainViewModel> {
        let viewModel = UpdatesTabMainViewModel()
        return UpdatesTabMainView(viewModel: viewModel)
    }
}

//extension UpdatesTabCoordinator: UpdatesTabMainCoordinatorDelegate {
//    
//    func tappedNav() {
//        print("tapped nav")
//    }
//    
//}

//MARK: - Preview
#Preview {
    UpdatesTabCoordinator(viewModel: .preview)
}
