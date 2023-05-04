//
//  CommunityArchiveFeedView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import SwiftUI

enum TimeGranularity: String, CaseIterable, CustomStringConvertible {
    
    case day, month, year // A user selects one to determine granularity of posts.
    
    var description: String {
        self.rawValue
    }
}

struct CommunityArchiveFeedView<ViewModel: CommunityArchiveFeedViewModelProtocol>: View {
    
    @StateObject private var viewModel: ViewModel
    @State private var date = Date()
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Time Granularity:")
                BoundMenu(
                    menuItems: TimeGranularity.allCases,
                    selectedItem: $viewModel.timeGranularity
                )
            }

            
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
        }
        

        // Calendar view
        // Top of all time
        // Bookmarked (by mods)
    }
}

struct CommunityArchiveFeedView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityArchiveFeedView(viewModel: CommunityArchiveFeedViewModel.preview)
    }
}
