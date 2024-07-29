//
//  SelectablePickerView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/24/24.
//

import SwiftUI
import SharedResourcesClientAndServer

struct SelectablePickerView<T: Selectable>: View {
    let tapAction: () -> Void
    let selection: T
    
    init(selection: T, tapAction: @escaping () -> Void) {
        self.selection = selection
        self.tapAction = tapAction
    }
    
    var body: some View {
        Button {
            tapAction()
        } label: {
            HStack(alignment: .center, spacing: ViewConstants.smallElementSpacing) {
                Image(systemName: T.metaImage.rawValue)
                    .font(.title3)
                    .foregroundStyle(Color.secondaryText)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(T.metaTitle)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.secondaryText)
                    
                    Text(selection.title)
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
        SelectablePickerView(selection: CommunityGovernment.autocracy) {
            return
        }
        .padding()
    }
}
