//
//  HistoryTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct HistoryTabCoordinator: View {
    
    @State private var viewModel: HistoryTabCoordinatorViewModel
    
    init(viewModel: HistoryTabCoordinatorViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        CoordinatorView(router: viewModel.router) {
            HistoryTabMainView(viewModel: viewModel.historyTabMainViewModel())
        } secondaryScreen: { (path: HistoryTabPath) in
            createViewFromPath(path)
        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: HistoryTabPath) -> some View {
        switch path {
        case .one: Text("")
        }
    }
    
    @MainActor
    func createHistoryTabMainView() -> HistoryTabMainView<HistoryTabMainViewModel> {
        let viewModel = HistoryTabMainViewModel()
        return HistoryTabMainView(viewModel: viewModel)
    }
}

// extension HistoryTabCoordinator: HistoryTabMainCoordinatorDelegate {
//
//    func tappedNav() {
//        print("tapped nav")
//    }
//    
// }

// MARK: - Preview
#Preview {
    HistoryTabCoordinator(viewModel: .preview)
}
