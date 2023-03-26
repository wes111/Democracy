//
//  ContentView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/14/23.
//

import Combine
import SwiftUI

let temp_authPublisher = CurrentValueSubject<Bool, Never>(false) // TODO: Replace in Dependeny Injector.

struct ContentView: View {
    var body: some View {
        let viewModel = RootViewModel()
        RootView(viewModel: viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
