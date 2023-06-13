//
//  CommunityArchiveFeedView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import SwiftUI

// TODO: Tappable area to show calendar is not expanding/contracting correctly.

// Archive should be sortable by topic and date. Date is more iportant?
struct CommunityArchiveFeedView: View {
    
    @StateObject private var viewModel: CommunityArchiveFeedViewModel
    @State var categoryCardSize = CGSize()
    @State var calendarPickerSize = CGSize()
    @State var date = Date()
    @State var isShowingCalendar = false
    
    init(viewModel: CommunityArchiveFeedViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private var gridItemLayout: [GridItem] = Array(repeating: .init(.flexible(), spacing: 20), count: 2)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            switch viewModel.communityArchiveType {
            case .category: communityCategories
            case .time: communityDates
            }
        }
    }
    
    var communityCategories: some View {
        LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: 15) {
            ForEach(viewModel.categoryViewModels, id: \.category) { categoryViewModel in
                CategoryCardView(viewModel: categoryViewModel)
                    .onTapGesture {
                        viewModel.goToCommunityPostCategory(categoryViewModel.category)
                    }
            }
        }
        .padding(20)
    }
    
    var communityDates: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            Text("Date")
                .font(.title)
            
            HStack {
                Text("Time Granularity:")
                    .lineLimit(1)
                
                BoundMenu(
                    menuItems: TimeGranularity.allCases,
                    selectedItem: $viewModel.timeGranularity
                )
                
                Spacer()
            }
            
            HStack {
                
                Button {
                    print("Button tapped.")
                } label: {
                    Text("Show posts for:")
                }
                
                ZStack {
                    
                    DatePicker(
                        "Show posts date",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .frame(width: calendarPickerSize.width, height: calendarPickerSize.height)
                    .clipped()
                    
                    Group {
                        switch viewModel.timeGranularity {
                        case .day:
                            Text("\(date.getFormattedDate(format: "MMMM dd, YYYY"))")
                        case .month:
                            Text("\(date.getFormattedDate(format: "MMMM, YYYY"))")
                        case .year:
                            Text("\(date.getFormattedDate(format: "YYYY"))")
                        }
                    }
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .preference(key: SizePreferenceKey2.self, value: proxy.size)
                        }
                    )
                    .background {
                        Color.white
                    }
                    .allowsHitTesting(false)
                    .onPreferenceChange(SizePreferenceKey2.self) { preferences in
                        self.calendarPickerSize = preferences
                    }

                }
            }
        
        }
        .padding(.horizontal)
    }
    
    func categoriesStack(_ categories: [String]) -> some View {
        
        Section {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(categories, id: \.self) { category in
                    Text(category)
                        .onTapGesture {
                            viewModel.goToCommunityPostCategory(category)
                        }
                }
            }
            
        } header: {
            Text("Post Categories")
                .font(.title)
                .padding(.horizontal)
        }
        .headerProminence(.increased)
    }
    
}

struct CommunityArchiveFeedView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityArchiveFeedView(viewModel: CommunityArchiveFeedViewModel.preview)
    }
}

struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: Value = .zero

    static func reduce(value _: inout Value, nextValue: () -> Value) {
        _ = nextValue()
    }
}

struct SizePreferenceKey2: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: Value = .zero

    static func reduce(value _: inout Value, nextValue: () -> Value) {
        _ = nextValue()
    }
}
