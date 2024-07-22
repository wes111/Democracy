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
    var categoriesFilter: [String]
    
    init(dateFilter: DateFilter = .all, sortOrder: SortOrder = .top, categoriesFilter: [String] = []) {
        self.dateFilter = dateFilter
        self.sortOrder = sortOrder
        self.categoriesFilter = categoriesFilter
    }
}

enum FilterPostsPath {
    case sortOrder
    case dateFilter
    case categoriesFilter
}

@MainActor @Observable
final class FilterPostsViewModel {
    var router = Router()
    var postFilters: PostFilters
    
    init(postFilters: PostFilters) {
        self.postFilters = postFilters
    }
    
    func navigateToPath(_ path: FilterPostsPath) {
        router.push(path)
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
        VStack(alignment: .leading, spacing: ViewConstants.largeElementSpacing) {
            title
            selectablePickerViews
        }
        .padding([.horizontal], ViewConstants.screenPadding)
        .padding(.bottom, ViewConstants.sheetBottomPadding)
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .background(Color.sheetBackground, ignoresSafeAreaEdges: .all)
        .toolbarNavigation(
            trailingContent: trailingToolbarContent,
            backgroundColor: .sheetBackground
        )
    }
    
    var title: some View {
        Text("Filter and Sort Posts")
            .multilineTextAlignment(.leading)
            .primaryTitle()
    }
    
    var selectablePickerViews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                tappableItem(selection: viewModel.postFilters.dateFilter, path: .dateFilter)
                tappableItem(selection: viewModel.postFilters.sortOrder, path: .sortOrder)
                // TODO: Categories...
            }
        }
    }
    
    func tappableItem<T: Selectable>(selection: T, path: FilterPostsPath) -> some View {
        TappableListItem(title: T.metaTitle, subtitle: selection.title) {
            viewModel.navigateToPath(path)
        }
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
        .frame(height: 350)
    }
    
    var trailingToolbarContent: [TopBarContent] {
        [.close({ dismiss() })]
    }
    
    @ViewBuilder
    func navigationScreen(path: FilterPostsPath) -> some View {
        switch path {
        case .sortOrder:
            EmptyView()
            
        case .dateFilter:
            SelectablePickerDetailView(selectedCategory: $viewModel.postFilters.dateFilter)
            
        case .categoriesFilter:
            EmptyView()
            
        }
    }
}

// MARK: - Preview
#Preview {
    FilterPostsView(viewModel: .preview)
}
