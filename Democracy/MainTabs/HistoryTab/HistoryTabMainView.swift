//
//  HistoryTabMainView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct HistoryTabMainView<ViewModel: HistoryTabMainViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text("History")
    }
}

struct HistoryTabMainView_Previews: PreviewProvider {
    static var previews: some View {
        let coordinator = HistoryTabCoordinator()
        let viewModel = HistoryTabMainViewModel(coordinator: coordinator)
        HistoryTabMainView(viewModel: viewModel)
    }
}
