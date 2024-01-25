//
//  CommunityCategoriesView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI

struct CommunityCategoriesView: View {
    @Bindable var viewModel: CommunityCategoriesViewModel
    
    var body: some View {
        EmptyView()
    }
}

// MARK: - Preview
#Preview {
    CommunityCategoriesView(viewModel: .preview)
}
