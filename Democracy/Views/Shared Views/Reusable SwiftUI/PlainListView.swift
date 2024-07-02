//
//  PlainListView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/14/24.
//

import SwiftUI

// A plain `List` View that removes the standard formatting from a default `List`.
// Make user to use `List` instead of `LazyVStack` for reusable cells (memory).
// https://www.reddit.com/r/SwiftUI/comments/xzluon/list_is_a_pain_in_the_ass/
@MainActor
struct PlainListView<ItemView: View, Item: Identifiable>: View {
    var items: [Item]
    @ViewBuilder let content: (Item) -> ItemView
    
    init(items: [Item], @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.content = content
    }
    
    var body: some View {
        List(items) { post in
            content(post)
                .listRowInsets(.init(
                    top: 0,
                    leading: 0,
                    bottom: ViewConstants.smallElementSpacing,
                    trailing: 0
                ))
                .listRowBackground(Color.primaryBackground)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

// A `ViewModifier` version of `PlainListView`
struct PlainListModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        List {
            content
                .listRowInsets(.init(
                    top: 0,
                    leading: 0,
                    bottom: ViewConstants.smallElementSpacing,
                    trailing: 0
                ))
                .listRowBackground(Color.primaryBackground)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .clipped()
    }
}

// MARK: View Extension
extension View {
    func plainListModifier() -> some View {
        modifier(PlainListModifier())
    }
}

// MARK: - Preview
//#Preview {
//    ZStack {
//        Color.primaryBackground.ignoresSafeArea(.all)
//        
//        PlainListView(
//            items: Post.previewArray.map { $0.toViewModel(coordinator: nil) },
//            content: { post in
//                PostCardView(viewModel: post)
//            })
//    }
//}
