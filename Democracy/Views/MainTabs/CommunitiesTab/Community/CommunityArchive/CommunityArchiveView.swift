//
//  CommunityArchiveFeedView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import SwiftUI

@MainActor
struct CommunityArchiveFeedView: View {
    @State private var viewModel: CommunityArchiveViewModel
    
    private let gridItemLayout: [GridItem] = Array(
        repeating: .init(.flexible(), spacing: ViewConstants.elementSpacing),
        count: 2
    )
    
    init(viewModel: CommunityArchiveViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .padding(.top, ViewConstants.smallElementSpacing)
    }
}

// MARK: - Subviews
private extension CommunityArchiveFeedView {
    
    var content: some View {
        LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: ViewConstants.elementSpacing) {
            GridRow {
                communityCategory(nil)
            }
            
            ForEach(viewModel.categories, id: \.self) { category in
                communityCategory(category)
            }
        }
        .padding(.horizontal, ViewConstants.screenPadding)
    }
    
    func communityCategory(_ category: PostCategory?) -> some View {
        Button {
            viewModel.goToCommunityPostCategory(category: category)
        } label: {
            VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
                Image("BMW")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .aspectRatio(1.75, contentMode: .fit)
                    .clipped()
                
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(viewModel.nameForCategory(category))
                            .foregroundStyle(Color.primaryText)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        
                        Text(viewModel.postCountStringForCategory(category))
                            .font(.caption2)
                            .foregroundColor(.tertiaryText)
                    }
                    
                    Spacer()
                    
                    Image(systemName: SystemImage.chevronRight.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.tertiaryText)
                }
            }
            .padding(ViewConstants.smallInnerBorder)
            .background(
                Color.secondaryBackground,
                in: RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
            )
        }
    }
}

// MARK: - Preview
#Preview {
    PreviewService.registerMocks()
    return ZStack {
        Color.primaryBackground.ignoresSafeArea(.all)
        CommunityArchiveFeedView(viewModel: .preview)
    }
}
