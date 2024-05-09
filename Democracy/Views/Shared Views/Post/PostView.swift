//
//  PostView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import SwiftUI

@MainActor
struct PostView: View {
    @State private var viewModel: PostViewModel
    
    init(viewModel: PostViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .background(Color.primaryBackground, ignoresSafeAreaEdges: .all)
            .toolbarNavigation(
                leadingContent: viewModel.leadingContent,
                centerContent: viewModel.centerContent,
                trailingContent: viewModel.trailingContent
            )
    }
}

// MARK: - Subviews
private extension PostView {
    var content: some View {
        OutlineGroup(viewModel.testComments, id: \.value, children: \.children) { commentNode in
            Text(commentNode.value.content)
                .padding(40)
                .frame(maxWidth: .infinity)
                .border(Color.yellow)
        }
        .plainListModifier()
        .padding(.horizontal, ViewConstants.screenPadding)
        .disclosureGroupStyle(CustomDisclosureGroupStyle())
        .border(Color.blue)
    }
}

struct CustomDisclosureGroupStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            configuration.label
            loadRepliesButton(configuration)
        }
        
        if configuration.isExpanded {
            replies(configuration)
        }
    }
    
    func replies(_ configuration: Configuration) -> some View {
        HStack {
            Divider()
                .overlay(.pink)
                .padding(.leading, 4)
            
            VStack {
                configuration.content
                    .padding(.leading, 8)
                    .disclosureGroupStyle(self)
            }

        }

    }
    
    func loadRepliesButton(_ configuration: Configuration) -> some View {
        Button {
            withAnimation {
                configuration.isExpanded.toggle()
            }
            
        } label: {
            Label(
                title: { Text("\(configuration.isExpanded ? "Hide" : "View") Replies") },
                icon: {
                    Image(systemName: configuration.isExpanded ? SystemImage.chevronUp.rawValue : SystemImage.chevronDown.rawValue)
                }
            )
            .labelStyle(ReversedLabelStyle())
            .contentShape(Rectangle())
            .font(.caption2)
        }
        .foregroundStyle(Color.yellow)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PostView(viewModel: PostViewModel.preview)
    }
}
