//
//  CommentDisclosureGroupStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/11/24.
//

import SwiftUI

struct CommentDisclosureGroupStyle: DisclosureGroupStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .bottomTrailing) {
            configuration.label
            
            Button {
                configuration.isExpanded.toggle()
            } label: {
                Label {
                    Text("\(configuration.isExpanded ? "Hide" : "View") Replies")
                } icon: {
                    Image(systemName: !configuration.isExpanded ? SystemImage.chevronDown.rawValue : SystemImage.chevronUp.rawValue)
                }
                .labelStyle(ReversedLabelStyle())
                .font(.footnote)
            }
            .foregroundStyle(Color.white)
            .padding(.trailing, ViewConstants.screenPadding)
            .padding(.bottom, ViewConstants.smallElementSpacing)
        }
        .onAppear {
            configuration.isExpanded = true
        }
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        .listRowBackground(Color.primaryBackground)
        .listRowSeparator(.hidden)
        
        if configuration.isExpanded {
            configuration.content
                .disclosureGroupStyle(self)
        }
    }
}
