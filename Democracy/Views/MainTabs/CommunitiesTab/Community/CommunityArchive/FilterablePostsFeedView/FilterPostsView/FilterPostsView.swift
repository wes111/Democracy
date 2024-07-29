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
    
    func goBack() {
        router.pop()
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
        .background(Color.sheetBackground, ignoresSafeAreaEdges: .all)
        .toolbarNavigation(
            leadingContent: leadingToolbarContent,
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
                
                // TODO: Categories...
            }
        }
        .contentMargins(.top, ViewConstants.scrollViewTopContentMargin)
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
    }
    
    func tappableItem<T: Selectable>(selection: T, path: FilterPostsPath) -> some View {
        SelectablePickerView(selection: selection) {
            viewModel.navigateToPath(path)
        }
    }
    
    var applyButton: some View {
        Button {
            // TODO: - Give the fitler/sort object back to the parent viewModel. And dismiss
            dismiss()
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
                backAction: viewModel.goBack,
                closeAction: { dismiss() }
            )
            
        case .dateFilter:
            SelectablePickerDetailNavigationView(
                selectedCategory: $viewModel.postFilters.dateFilter,
                backAction: viewModel.goBack,
                closeAction: { dismiss() }
            )
            
        case .categoriesFilter:
            EmptyView()
            
        }
    }
}

// MARK: - Preview
#Preview {
    FilterPostsView(viewModel: .preview)
}
