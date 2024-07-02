//
//  CustomLinkProviderView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/27/24.
//

import SwiftUI

@MainActor
struct CustomLinkProviderView: View {
    @Environment(\.openURL) var openURL
    @State private var viewModel: LinkProviderViewModel
    @State private var availableImageHeight: CGFloat = 1.0
    @State private var availableWidth: CGFloat = 1.0
    
    init(viewModel: LinkProviderViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .task {
                await viewModel.fetchMetadata()
            }
            .background(
                GeometryReader { proxy in
                    let proxyWidth = proxy.size.width
                    Color.clear
                        .task(id: proxy.size.width) {
                            $availableWidth.wrappedValue = max(proxyWidth, 0)
                        }
                }
            )
    }
}

// MARK: - Subviews
private extension CustomLinkProviderView {
    var content: some View {
        Button {
            openURL(viewModel.previewUrl)
        } label: {
            primaryLayout
                .padding(ViewConstants.smallInnerBorder)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Color.secondaryBackground,
                    in: RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
                )
        }
        // Hack: We need plain button style here (instead of link) so we can limit the size of the
        // tappable area within a list.
        .buttonStyle(.plain)
    }
    
    var primaryLayout: some View {
        ZStack(alignment: .bottomTrailing) {
            HStack(spacing: ViewConstants.elementSpacing) {
                if let uiImage = viewModel.image {
                    image(uiImage)
                }
                
                VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
                    if let titleText = viewModel.title {
                        title(titleText)
                    }
                    
                    if let url = viewModel.url {
                        link(url)
                    }
                }
                
                Spacer()
            }
            
            Image(systemName: SystemImage.arrowUpRightSquare.rawValue)
                .foregroundStyle(Color.secondaryText)
        }
    }
    
    func image(_ image: UIImage) -> some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: availableImageHeight, maxHeight: availableWidth / 3)
            .clipped()
            .cornerRadius(ViewConstants.cornerRadius)
            .background(
                GeometryReader { proxy in
                    let proxyHeight = proxy.size.height
                    Color.clear
                        .task(id: proxy.size.height) {
                            $availableImageHeight.wrappedValue = max(proxyHeight, 0)
                            print(max(proxyHeight, 0))
                        }
                }
            )
    }
    
    func title(_ title: String) -> some View {
        Text(title)
            .foregroundStyle(Color.primaryText)
            .font(.footnote)
            .lineLimit(3)
            .multilineTextAlignment(.leading)
            .minimumScaleFactor(ViewConstants.minTextScale)
    }
    
    func link(_ url: String) -> some View {
        Text(url)
            .font(.caption2)
            .foregroundColor(Color.tertiaryText)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
            .minimumScaleFactor(ViewConstants.minTextScale)
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        VStack(spacing: 25) {
            CustomLinkProviderView(viewModel: .preview)
                .frame(maxHeight: 100)
            
            CustomLinkProviderView(viewModel: .preview)
                .frame(maxHeight: 150)
            
            CustomLinkProviderView(viewModel: .preview)
        }
    }
}
