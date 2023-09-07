//
//  AboutSection.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/5/23.
//

import SwiftUI

struct AboutSection: View {
    
    private let viewModel: AboutSectionViewModel
    
    init(viewModel: AboutSectionViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("About")
                    .font(.title)
                
                Spacer()
                
                Button {
                    print()
                } label: {
                    Text("Join")
                        .font(.title3)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 3)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.otherRed)
                        )
                }
            }

            HStack(spacing: 10) {
                Text(viewModel.memberCountString)
                
                Divider()
                    .overlay(Color.tertiaryText)
                
                Text(viewModel.foundedDateString)
            }
            .font(.footnote)
                
            Text(viewModel.summary)
                .font(.caption)
                .foregroundColor(.secondaryText)
        }
    }
}

//MARK: - Preview
#Preview {
    let viewModel = AboutSectionViewModel(
        summary: "summary",
        memberCount: 100,
        foundedDate: Date())
    
    return AboutSection(viewModel: viewModel)
}
