//
//  VotingTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct VotingTabCoordinator: View {
    
    @StateObject private var viewModel: VotingTabCoordinatorViewModel
    
    init(viewModel: VotingTabCoordinatorViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        CoordinatorView(router: $viewModel.router) {
            VotingTabMainView(viewModel: viewModel.votingTabMainViewModel())
        } secondaryScreen: { (path: VotingTabPath) in
            createViewFromPath(path)
        }
        //.fullScreenCover(item: <#T##Binding<Identifiable?>#>, content: <#T##(Identifiable) -> View#>)
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: VotingTabPath) -> some View {
        switch path {
        case .one: EmptyView()
        }
    }
}

extension VotingTabCoordinator: VotingTabMainCoordinatorDelegate {
    
    func tappedNav() {
        print("tapped nav")
    }
    
}

// MARK: - Preview
struct VotingTabCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = VotingTabCoordinatorViewModel()
        VotingTabCoordinator(viewModel: viewModel)
    }
}
