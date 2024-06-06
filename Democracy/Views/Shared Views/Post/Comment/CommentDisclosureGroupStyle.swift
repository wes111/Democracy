//
//  CommentDisclosureGroupStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/11/24.
//

import SwiftUI

struct CommentDisclosureGroupStyle: DisclosureGroupStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .bottomLeading) {
            configuration.label
            LoadRepliesButton(
                isArrowDown: !configuration.isExpanded,
                title: "\(configuration.isExpanded ? "Hide" : "View") Replies",
                action: { configuration.isExpanded.toggle() }
            )
            .padding(.leading, ViewConstants.screenPadding)
            .padding(.vertical, ViewConstants.screenPadding / 2)
        }
        .onAppear {
            configuration.isExpanded = true
        }
        
        if configuration.isExpanded {
            replies(configuration)
        }
    }
    
    func replies(_ configuration: Configuration) -> some View {
        HStack {
            Divider()
                .overlay(Color.tertiaryText)
                .padding(.leading, ViewConstants.screenPadding)
            
            VStack {
                configuration.content
                    .disclosureGroupStyle(self)
            }
        }
    }
}

struct LoadRepliesButton: View { // TODO: Move to own file...
    
    var isArrowDown: Bool
    var title: String
    let action: () async -> Void
    
    var body: some View {
        AsyncButton(
            action: action,
            label: {
                Label {
                    Text(title)
                } icon: {
                    Image(systemName: isArrowDown ? SystemImage.chevronDown.rawValue : SystemImage.chevronUp.rawValue)
                }
                .labelStyle(ReversedLabelStyle())
                .font(.footnote)
            },
            showProgressView: .constant(false)
        )
        .foregroundStyle(Color.white)
    }
}
