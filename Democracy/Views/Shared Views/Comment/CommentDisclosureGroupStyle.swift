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
            viewRepliesButton(configuration)
                .padding(.leading, ViewConstants.screenPadding)
                .padding(.vertical, ViewConstants.screenPadding / 2)
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
    
    func viewRepliesButton(_ configuration: Configuration) -> some View {
        Button {
            withAnimation {
                configuration.isExpanded.toggle()
            }
        } label: {
            Label {
                Text("\(configuration.isExpanded ? "Hide" : "View") Replies")
            } icon: {
                Image(systemName: configuration.isExpanded ?
                      SystemImage.chevronUp.rawValue : SystemImage.chevronDown.rawValue
                )
            }
            .labelStyle(ReversedLabelStyle())
            .font(.footnote)
        }
        .foregroundStyle(Color.white)
    }
}
