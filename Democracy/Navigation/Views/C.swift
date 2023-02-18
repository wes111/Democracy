//
//  C.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/16/23.
//

import SwiftUI

struct C<ViewModel: ViewModelCProtocol>: View {

    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Text("This is C!")
            Button("Go to B") {
                viewModel.CToB()
            }
            Button("Go to E") {
                viewModel.CToE()
            }
            Button("Go to D") {
                viewModel.CToD()
            }
        }
    }
}

struct C_Previews: PreviewProvider {
    static var previews: some View {
        let coordinator = MainCoordinator()
        let viewModel = ViewModelC(coordinator: coordinator)
        C(viewModel: viewModel)
    }
}
