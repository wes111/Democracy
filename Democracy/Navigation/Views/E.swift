//
//  E.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/16/23.
//

import SwiftUI

struct E<ViewModel: ViewModelEProtocol>: View {

    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Text("This is E!")
            Button("Go to C") {
                viewModel.EToC()
            }
            Button("Go to B") {
                viewModel.EToB()
            }
            Button("Go to D") {
                viewModel.EToD()
            }
        }
    }
}

struct E_Previews: PreviewProvider {
    static var previews: some View {
        let coordinator = MainCoordinator(parentCoordinator: MainTabCoordinator())
        let viewModel = ViewModelE(coordinator: coordinator)
        E(viewModel: viewModel)
    }
}
