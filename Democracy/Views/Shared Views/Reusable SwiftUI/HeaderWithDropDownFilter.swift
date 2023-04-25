//
//  HeaderWithDropDownFilter.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/24/23.
//

import SwiftUI

struct HeaderWithDropDownFilter<T: Hashable>: View where T: RawRepresentable, T.RawValue == String {
    
    let title: String
    let menuItems: [T]
    @Binding var selectedItem: T
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .padding(.trailing)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Menu {
                ForEach(menuItems, id: \.self) { repType in
                    Button(repType.rawValue.capitalized) {
                        selectedItem = repType
                    }
                }
            } label: {
                HStack {
                    Text(selectedItem.rawValue.capitalized)
                    Image(systemName: "chevron.down")
                }
                .frame(maxWidth: 125)
                .border(Color.red)
            }
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
