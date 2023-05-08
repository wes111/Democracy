//
//  CategoryCardView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/7/23.
//

import SwiftUI

struct CategoryCardView<ViewModel: CategoryCardViewModelProtocol>: View {
    
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Text(viewModel.category)
                .font(.headline)
            Text("\(viewModel.postCount)")
        }
        .frame(width: 100, height: 75, alignment: .center)
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.random())
        )
    }
    
}

struct CategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCardView(viewModel: CategoryCardViewModel.preview)
    }
}
