//
//  E.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/16/23.
//

import SwiftUI

struct SettingsView<ViewModel: SettingsViewModelProtocol>: View {

    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Text("Settings")
            Button("Go to C") {
                
            }
            Button("Go to B") {
                
            }
            Button("Go to D") {
                
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        let coordinator = SettingsCoordinator()
        let viewModel = SettingsViewModel(coordinator: coordinator)
        SettingsView(viewModel: viewModel)
    }
}
