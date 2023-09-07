//
//  EventsTabMainView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct EventsTabMainView<ViewModel: EventsTabMainViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text("Events")
    }
}

//MARK: - Preview
#Preview {
    EventsTabMainView(viewModel: EventsTabMainViewModel.preview)
}
