//
//  CategoryCardView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/7/23.
//

import SwiftUI

struct CategoryCardView: View {
    
    @StateObject private var viewModel: CategoryCardViewModel
    
    init(category: CommunityCategory) {
        _viewModel = StateObject(wrappedValue: CategoryCardViewModel(category: category))
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            VStack(spacing: 0) {
                
                Image(viewModel.category.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 175)
                
                HStack {
                    Text(viewModel.category.name)
                        .font(.caption)
                        .padding(4)
                        .frame(width: 175)
                }
                .background(
                    Rectangle()
                        .foregroundColor(Color.secondaryBackground)
                )
            }
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Label("\(viewModel.postCount)",
                  systemImage: "book.closed.fill"
            )
            .labelStyle(ReversedLabelStyle())
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.secondaryBackground)
            )
            .padding(10)
        }
        .foregroundColor(Color.primaryText)
    }
}

struct CategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCardView(category: CommunityCategory.preview)
            .frame(height: 100)
    }
}
