//
//  CandidateView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import SwiftUI

struct CandidateView<ViewModel: CandidateViewModelProtocol>: View {
    
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            if let imageName = viewModel.candidate.imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 250)
            }
            Text("The candidate's main page. Added to stack.")
            Text("Bernie Sanders")
        }
    }
    
}

struct CandidateView_Previews: PreviewProvider {
    static var previews: some View {
        CandidateView(viewModel: CandidateViewModel.preview)
    }
}
