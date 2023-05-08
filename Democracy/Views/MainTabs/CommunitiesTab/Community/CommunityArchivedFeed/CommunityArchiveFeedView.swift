//
//  CommunityArchiveFeedView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import SwiftUI

// Archive should be sortable by topic and date. Date is more iportant?
// Show past 7 days and then user has to navigate for more date granularity or topics. top 5 per day?
struct CommunityArchiveFeedView<ViewModel: CommunityArchiveFeedViewModelProtocol>: View {
    
    @StateObject private var viewModel: ViewModel
    @State var size: CGSize = CGSize()
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private var gridItemLayout: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0), count: 3)
    
    var body: some View {
        ScrollView(.vertical) {
            ScrollView(.horizontal) {
                LazyHGrid(rows: gridItemLayout, alignment: .center, spacing: 0) {
                    ForEach(viewModel.categoryViewModels, id: \.category) { categoryViewModel in
                        CategoryCardView(viewModel: categoryViewModel)
                            .onTapGesture {
                                viewModel.goToCommunityPostCategory(categoryViewModel.category)
                            }
                            .background(
                                GeometryReader { proxy in
                                    Color.clear
                                        .preference(key: SizePreferenceKey.self, value: proxy.size)
                                }
                            )
                    }
                }
            }
            .onPreferenceChange(SizePreferenceKey.self) { preferences in
                self.size = preferences
            }
            .frame(minHeight: size.height * 3)
        }
    }
    
//    var body: some View {
//
//        VStack {
//
//            HStack {
//                Text("Time Granularity:")
//                    .lineLimit(1)
//
//                BoundMenu(
//                    menuItems: TimeGranularity.allCases,
//                    selectedItem: $viewModel.timeGranularity
//                )
//
//                switch viewModel.timeGranularity {
//                case .year:
//                    yearPicker
//                case .month:
//                    monthPicker
//                case .day:
//                    datePicker
//                }
//            }
//
//            Spacer()
//        }
//    }
//
//    var datePicker: some View { // TODO: Set the date bounds on this.
//        DatePicker(
//            "Start Date",
//            selection: $date,
//            displayedComponents: [.date]
//        )
//        .datePickerStyle(.compact)
//        .labelsHidden()
//    }
//
//    var monthPicker: some View {
//        BoundMenu(
//            menuItems: Month.allCases,
//            selectedItem: $viewModel.selectedMonth
//        )
//    }
//
//    var yearPicker: some View {
//        BoundMenu(
//            menuItems: Date.yearsArraySinceCreation,
//            selectedItem: $viewModel.selectedYear)
//    }
    
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
