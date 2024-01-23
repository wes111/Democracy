//
//  HorizontalProgressView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/23/24.
//

import SwiftUI

struct HorizontalProgressView: View {
    let totalProgress: Int
    let currentProgress: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            ForEach((0...totalProgress - 1), id: \.self) { progress in
                let hasProgressed = progress <= currentProgress
                RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
                    .fill(hasProgressed ? Color.tertiaryText : Color.secondaryBackground)
                    .frame(height: 3.5)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        HorizontalProgressView(totalProgress: 5, currentProgress: 2)
            .padding()
    }
}
