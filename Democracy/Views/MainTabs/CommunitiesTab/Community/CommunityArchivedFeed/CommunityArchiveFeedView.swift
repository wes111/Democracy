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
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        List {
            Group {
                
                categoriesStack(viewModel.community.postCategories)
                
                ForEach(viewModel.initialDates, id: \.self) { date in
                    topPostsForDateSection(
                        date: date,
                        topPosts: viewModel.topPostsForDate(date)
                    )
                }
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
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
    
    func topPostsForDateSection(date: Date, topPosts: [PostCardViewModel]) -> some View {
        
        Section {
            VStack(spacing: 10) {
                ForEach(topPosts, id: \.post) { postCardViewModel in
                    PostCardView(viewModel: postCardViewModel)
                }
            }
            
        } header: {
            Text(date.getFormattedDate(format: "MMMM dd"))
                .font(.title)
                .padding(.horizontal)
        }
        //.headerProminence(.increased)
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
