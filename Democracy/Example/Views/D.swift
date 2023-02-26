//
//  D.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/16/23.
//

import SwiftUI

struct D<ViewModel: ViewModelDProtocol>: View {

    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Text("This is D!")
            Button("Go to C") {
                viewModel.DToC()
            }
            Button("Go to E") {
                viewModel.DToE()
            }
            Button("Go to B") {
                viewModel.DToB()
            }
        }
    }
}

struct D_Previews: PreviewProvider {
    static var previews: some View {
        let coordinator = MainCoordinator()
        let viewModel = ViewModelD(coordinator: coordinator)
        D(viewModel: viewModel)
    }
}
