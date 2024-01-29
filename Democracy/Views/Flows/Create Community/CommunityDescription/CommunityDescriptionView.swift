//
//  CommunityDescriptionView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI

struct CommunityDescriptionView: View {
    @Bindable var viewModel: CommunityDescriptionViewModel
    @FocusState private var focusedField: CreateCommunityFlow?
    
    var body: some View {
        UserTextEditorInputView(
            viewModel: viewModel,
            focusedField: $focusedField
        )
        .onAppear {
            viewModel.onAppear()
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityDescriptionView(viewModel: .preview)
    }
}
