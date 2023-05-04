//
//  CommunityInfoView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import SwiftUI
    
struct CommunityInfoView<ViewModel: CommunityInfoViewModelProtocol>: View {
    
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
            // TODO: This might need to be a scrollView so we can get the content offset to hide the picker.
            List {
                Group {
                    AboutSection()
                    
                    LeadershipSection(viewModel: viewModel)
                    
                    AlliedCommunitiesSection(
                        communities: viewModel.alliedCommunities,
                        onTapAction: viewModel.onTapCommunityCard
                    )
                    
                    ListSection(
                        items: viewModel.community.rules,
                        sectionTitle: "Rules"
                    )
                    
                    ListSection(
                        items: viewModel.community.resources,
                        sectionTitle: "Resources",
                        onItemTap: viewModel.openResourceURL
                    )
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
        }
}

// MARK: - About Section

struct AboutSection: View {
    
    var body: some View {
        Section {
            Text("Welcome to the Community, blah, blah, blah")
        } header: {
            Text("About")
                .font(.title)
        }
        .padding(.horizontal)
        .headerProminence(.increased)
    }
}

// MARK: - Allied Communities Section

struct AlliedCommunitiesSection: View {
    
    let communities: [Community]
    let onTapAction: (Community) -> Void
    
    var body: some View {
        
        Section {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(communities, id: \.self) { community in
                        CommunityCard(community: community)
                            .onTapGesture {
                                onTapAction(community)
                            }
                            .padding(.leading)
                    }
                }
            }
            
        } header: {
            Text("Allied Communities")
                .font(.title)
                .padding(.horizontal)
            
        }
        .headerProminence(.increased)
    }
}

// MARK: - Representatives Section

struct LeadershipSection<ViewModel: CommunityInfoViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        Section {
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.representatives, id: \.self) { representative in
                        createCandidateCardView(representative)
                            .padding(.leading)
                    }
                }
            }
            
        } header: {
            VStack(alignment: .leading) {
                Text("Representatives")
                    .font(.title)
                Button {
                    viewModel.showCandidates()
                } label: {
                    Label("Go to Candidates", systemImage: "chevron.right")
                        .labelStyle(ReversedLabelStyle())
                }
            }
            .padding(.horizontal)
            
        }
        .headerProminence(.increased)
    }
    
    // This method is a duplicate. Refactor
    private func createCandidateCardView(_ candidate: Candidate) -> CandidateCardView<CandidateCardViewModel> {
        let viewModel = CandidateCardViewModel(coordinator: viewModel.coordinator, candidate: candidate)
        return CandidateCardView(viewModel: viewModel)
    }
}

// MARK: - List Section

struct ListSection: View {
    
    @State private var isExpanded = false
    let items: [String]
    let sectionTitle: String
    private let unexpandedCount = 3
    private let onItemTap: ((String) -> Void)?
    
    init(items: [String], sectionTitle: String, onItemTap: ( (String) -> Void)? = nil) {
        self.items = items
        self.sectionTitle = sectionTitle
        self.onItemTap = onItemTap
    }
    
    var body: some View {
        Section {
            let shouldShowAllItems = isExpanded || items.count <= unexpandedCount
            let partialIndices = items.indices.clamped(to: Range(uncheckedBounds: (0, unexpandedCount)))
            let visibleIndices = shouldShowAllItems ? items.indices : partialIndices
            
            VStack(alignment: .leading, spacing: 5) {
                ForEach(visibleIndices, id: \.self) { index in
                    Text("\(index + 1).) \(items[index])")
                        .onTapGesture {
                            if let onItemTap {
                                onItemTap(items[index])
                            }
                        }
                }
            }

            Button {
                isExpanded.toggle()
            } label: {
                Text(isExpanded ? "Collapse" : "Expand")
            }

            
        } header: {
            Text(sectionTitle)
                .font(.title)
        }
        .headerProminence(.increased)
        .padding(.horizontal)
    }
}

struct CommunityInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityInfoView(viewModel: CommunityInfoViewModel.preview)
    }
}
