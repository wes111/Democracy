//
//  HorizontalSelectableList.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/11/24.
//

import SwiftUI

struct HorizontalSelectableList<T: Selectable>: View {
    
    @Binding var selection: T
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: ViewConstants.smallElementSpacing) {
                ForEach(T.allCases) { option in
                    optionView(option)
                }
            }
        }
    }
    
    func optionView(_ option: T) -> some View {
        return Text(option.title)
            .tagModifier()
            .overlay(
                RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
                    .strokeBorder(
                        selection == option ? Color.tertiaryText : Color.primaryBackground,
                        lineWidth: ViewConstants.thinBorderWidth
                    )
            )
            .onTapGesture {
                selection = option
            }
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        HorizontalSelectableList(selection: .constant(ResourceCategory.book))
    }
}
