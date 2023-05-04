//
//  HeaderWithDropDownFilter.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/24/23.
//

import SwiftUI

struct HeaderWithDropDownFilter<T: Hashable>: View where T: CustomStringConvertible {
    
    let title: String
    let menuItems: [T]
    @Binding var selectedItem: T
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .padding(.trailing)
                .lineLimit(1)
                .layoutPriority(1.0)
                .minimumScaleFactor(0.5)
            
            BoundMenu(
                menuItems: menuItems,
                selectedItem: $selectedItem
            )
        }
    }
    
}


struct HeaderWithDropDownFilter_Previews: PreviewProvider {
    static var previews: some View {
        HeaderWithDropDownFilter(
            title: "Filterable Results",
            menuItems: RepresentativeType.allCases,
            selectedItem: .constant(.legislator)
        )
    }
}
