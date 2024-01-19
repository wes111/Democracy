//
//  CustomPicker.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/18/24.
//

import SwiftUI

// Standardized Picker
// Purpose is to wrap the UIKit in the initializer.
struct CustomPicker<Selection: Hashable, Content: View>: View {
    @ViewBuilder let content: Content
    let title: String
    var selection: Binding<Selection>
    
    @MainActor
    init(
        title: String,
        selection: Binding<Selection>,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.selection = selection
        self.content = content()
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.init(.secondaryBackground)
        UISegmentedControl.appearance().backgroundColor = UIColor.init(.primaryBackground)
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.init(.secondaryText)],
            for: .normal
        )
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.init(.primaryText)],
            for: .selected
        )
    }
    
    var body: some View {
        Picker(title, selection: selection) {
            content
        }
        .pickerStyle(.segmented)
    }
}

// MARK: - Preview
#Preview {
    @State var selection: PostBodyTab = .editor
    return ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        CustomPicker(title: "Picker", selection: $selection) {
            ForEach(PostBodyTab.allCases, id: \.self) { tab in
                Text(tab.rawValue.capitalized).tag(tab)
            }
        }
        .padding()
    }
}
