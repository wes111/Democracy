//
//  B.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/16/23.
//

import SwiftUI

struct B<ViewModel: ViewModelBProtocol>: View {

    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Text("This is B!")
            Button("Go to C") {
                viewModel.BToC()
            }
            Button("Go to E") {
                viewModel.BToE()
            }
            Button("Go to D") {
                viewModel.BToD()
            }
        }
    }
}

struct B_Previews: PreviewProvider {
    static var previews: some View {
        let coordinator = MainCoordinator()
        let viewModel = ViewModelB(coordinator: coordinator)
        B(viewModel: viewModel)
    }
}
