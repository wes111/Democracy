//
//  SelectablePickerView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/24/24.
//

import SwiftUI
import SharedResourcesClientAndServer

@MainActor
struct TappableListItem: View {
    let title: String
    let subtitle: String
    let image: SystemImage?
    let tapAction: () -> Void
    
    init(title: String, subtitle: String, image: SystemImage? = nil, tapAction: @escaping () -> Void) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.tapAction = tapAction
    }
    
    var body: some View {
        Button {
            tapAction()
        } label: {
            HStack(alignment: .center, spacing: ViewConstants.smallElementSpacing) {
                if let imageName = image?.rawValue {
                    Image(systemName: imageName)
                        .font(.title3)
                        .foregroundStyle(Color.secondaryText)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(title)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.secondaryText)
                    
                    Text(subtitle)
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.secondaryText.opacity(0.5))
                }
                
                Spacer()
                
                Image(systemName: SystemImage.chevronRight.rawValue)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.secondaryText.opacity(0.25))
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TappableListItem(
            title: "Tappable Title",
            subtitle: "Tappable Subtitle",
            image: .arrowRight,
            tapAction: {}
        )
        .padding()
    }
}
