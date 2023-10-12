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

//MARK: - Preview
#Preview {
    let viewModel = SettingsViewModel()
    return SettingsView(viewModel: viewModel)
}
