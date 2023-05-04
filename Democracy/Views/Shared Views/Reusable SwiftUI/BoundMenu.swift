//
//  BoundMenu.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/24/23.
//

import SwiftUI

struct BoundMenu<T: Hashable & CustomStringConvertible>: View {
    
    let menuItems: [T]
    @Binding var selectedItem: T
    
    var body: some View {
        
        Menu {
            ForEach(menuItems, id: \.self) { item in
                Button(item.description.capitalized) {
                    selectedItem = item
                }
            }
        } label: {
            HStack() {
                Text(selectedItem.description.capitalized)
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
