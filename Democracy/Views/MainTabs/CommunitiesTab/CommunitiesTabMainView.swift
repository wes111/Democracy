//
//  CommunitiesTabMainView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct CommunitiesTabMainView<ViewModel: CommunitiesTabMainViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    @State private var multiSelection = Set<UUID>()
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        List(viewModel.communities, selection: $multiSelection) { community in
            HStack {
                Text(community.name)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .contentShape(Rectangle())
            .onTapGesture {
                viewModel.goToCommunity(community)
            }
            .listRowBackground(EmptyView()) // <-- Make rows "non-selectable."
            
        }
        .navigationTitle("Communities")
        .refreshable {
            viewModel.refreshCommunities()
        }
        .listStyle(.plain)
        .listSectionSeparator(.hidden, edges: .all)
        //.toolbar { EditButton() }
    }
}

struct CommunitiesTabMainView_Previews: PreviewProvider {
    static var previews: some View {
        CommunitiesTabMainView(viewModel: CommunitiesTabMainViewModel.preview)
    }
}
