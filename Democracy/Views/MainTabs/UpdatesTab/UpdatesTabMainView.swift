//
//  UpdatesTabMainView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct UpdatesTabMainView<ViewModel: UpdatesTabMainViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text("Updates")
    }
}

struct UpdatesTabMainView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatesTabMainView(viewModel: UpdatesTabMainViewModel.preview)
    }
}
