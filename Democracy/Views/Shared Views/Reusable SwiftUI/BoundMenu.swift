//
//  BoundMenu.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/24/23.
//

import SwiftUI

struct BoundMenu<T: Hashable>: View where T: RawRepresentable, T.RawValue == String {
    
    let menuItems: [T]
    @Binding var selectedItem: T
    
    var body: some View {
        
        Menu {
            ForEach(menuItems, id: \.self) { repType in
                Button(repType.rawValue.capitalized) {
                    selectedItem = repType
                }
            }
        } label: {
            HStack() {
                Text(selectedItem.rawValue.capitalized)
                Image(systemName: "chevron.down")
                Spacer()
            }
            .frame(maxWidth: 125)
            .border(Color.red)
        }
    }
}

struct BoundMenu_Previews: PreviewProvider {
    static var previews: some View {
        BoundMenu(
            menuItems: RepresentativeType.allCases,
            selectedItem: .constant(.legislator)
        )
    }
}
