//
//  CategoryCardView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/7/23.
//

import SwiftUI

struct CommunityCategoryView: View {
    
    let viewModel: CommunityCategoryViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            VStack(spacing: 0) {
                
//                Image(viewModel.imageName)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 175)
                
                HStack {
                    Text(viewModel.name)
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
            
            Label("\(10)",
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

// MARK: - Preview
#Preview {
    CommunityCategoryView(
        viewModel: CommunityCategoryViewModel(name: Community.preview.categories.first!)
    )
    .frame(height: 100)
}
