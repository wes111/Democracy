//
//  FilterPostsView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/21/24.
//

import SwiftUI

struct PostFilters {
    var dateFilter: DateFilter
    var sortOrder: SortOrder
    var tagsFilter: [String]
    
    init(dateFilter: DateFilter = .all, sortOrder: SortOrder = .top, categoriesFilter: [String] = []) {
        self.dateFilter = dateFilter
        self.sortOrder = sortOrder
        self.tagsFilter = categoriesFilter
    }
}

enum FilterPostsPath {
    case sortOrder
    case dateFilter
    case categoriesFilter
}

@MainActor @Observable
final class FilterPostsViewModel {
    let communityTags: [String]
    let onUpdateFilters: (PostFilters) -> Void
    var router = Router()
    var postFilters: PostFilters
    
    init(
        communityTags: [String],
        postFilters: PostFilters,
        onUpdateFilters: @escaping (PostFilters) -> Void
    ) {
        self.postFilters = postFilters
        self.communityTags = communityTags
        self.onUpdateFilters = onUpdateFilters
    }
    
    func navigateToPath(_ path: FilterPostsPath) {
        router.push(path)
    }
    
    func backAction() {
        router.pop()
    }
    
    func toggleTag(_ tag: String) {
        if postFilters.tagsFilter.contains(tag) {
            postFilters.tagsFilter.removeAll(where: { $0 == tag })
        } else {
            postFilters.tagsFilter.append(tag)
        }
    }
    
    var categoriesSubtitle: String {
        if postFilters.tagsFilter.isEmpty {
            "None Selected"
        } else {
            postFilters.tagsFilter.sorted().joined(separator: ", ")
        }
    }
    
    func onTapUpdateFilters() {
        onUpdateFilters(postFilters)
    }
}

@MainActor
struct FilterPostsView: View {
    @Bindable var viewModel: FilterPostsViewModel
    @Environment(\.dismiss) var dismiss
    @State private var height: CGFloat = .zero
    
    var body: some View {
        navigationStack
    }
}

// MARK: - Subviews
private extension FilterPostsView {
    
    var content: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            selectablePickerViews
            applyButton
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .background(Color.secondaryBackground, ignoresSafeAreaEdges: .all)
        .toolbarNavigation(
            leadingContent: leadingToolbarContent,
            trailingContent: trailingToolbarContent,
            backgroundColor: .secondaryBackground
        )
    }
    
    var title: some View {
        Text("Filter and Sort Posts")
            .multilineTextAlignment(.leading)
            .primaryTitle()
    }
    
    var selectablePickerViews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ViewConstants.largeElementSpacing) {
                Divider()
                    .overlay(Color.black)
                
                tappableItem(selection: viewModel.postFilters.sortOrder, path: .sortOrder)
                    .padding(.horizontal, ViewConstants.screenPadding)
                
                Divider()
                    .overlay(Color.black)
                
                tappableItem(selection: viewModel.postFilters.dateFilter, path: .dateFilter)
                    .padding(.horizontal, ViewConstants.screenPadding)
                
                Divider()
                    .overlay(Color.black)
                
                TappableListItem(title: "Tags Filter", subtitle: viewModel.categoriesSubtitle, image: .tag) {
                    viewModel.navigateToPath(.categoriesFilter)
                }
                .padding(.horizontal, ViewConstants.screenPadding)
                
                Divider()
                    .overlay(Color.black)
            }
        }
        .contentMargins(.top, ViewConstants.scrollViewTopContentMargin)
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
    }
    
    func tappableItem<T: Selectable>(selection: T, path: FilterPostsPath) -> some View {
        TappableListItem(title: T.metaTitle, subtitle: selection.title, image: T.metaImage) {
            viewModel.navigateToPath(path)
        }
    }
    
    var applyButton: some View {
        Button {
            viewModel.onTapUpdateFilters()
        } label: {
            Text("Apply")
        }
        .buttonStyle(PrimaryButtonStyle())
        .padding(ViewConstants.screenPadding)
    }
}

// MARK: - Navigation Subviews
private extension FilterPostsView {
    
    var navigationStack: some View {
        NavigationStack(path: $viewModel.router.navigationPath) {
            content
                .navigationDestination(for: FilterPostsPath.self) { path in
                    navigationScreen(path: path)
                }
        }
        .frame(height: 450)
    }
    
    var trailingToolbarContent: [TopBarContent] {
        [.close({ dismiss() })]
    }
    
    var leadingToolbarContent: [TopBarContent] {
        [.title("Sort & Filter", size: .large)]
    }
    
    @ViewBuilder
    func navigationScreen(path: FilterPostsPath) -> some View {
        switch path {
        case .sortOrder:
            SelectablePickerDetailNavigationView(
                selectedCategory: $viewModel.postFilters.sortOrder,
                backAction: viewModel.backAction
            )
            
        case .dateFilter:
            SelectablePickerDetailNavigationView(
                selectedCategory: $viewModel.postFilters.dateFilter,
                backAction: viewModel.backAction
            )
            
        case .categoriesFilter:
            TagsPickerNavigationView(viewModel: viewModel)
        }
    }
}

// MARK: - Preview
#Preview {
    FilterPostsView(viewModel: .preview)
}
