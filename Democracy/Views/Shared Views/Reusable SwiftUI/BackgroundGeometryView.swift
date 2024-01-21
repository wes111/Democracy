//
//  BackgroundGeometryView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/29/23.
//

import SwiftUI

// Allows for reading the size of a view via a GeometryReader in the View's background.
// https://medium.com/ancestry-product-and-technology/swiftui-pro-tips-preferencekey-360505ff8fbb
struct BackgroundGeometryView<Content: View>: View {
    @Binding var size: CGSize
    @ViewBuilder let content: Content
    
    init(
        size: Binding<CGSize>,
        @ViewBuilder content: () -> Content
    ) {
        self._size = size
        self.content = content()
    }
    
    var body: some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: geometry.size)
                }
                    .onPreferenceChange(SizePreferenceKey.self) { newSize in
                        size = newSize
                    }
            )
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

extension View {
    func addGeometryBackground(size: Binding<CGSize>) -> some View {
        BackgroundGeometryView(size: size) {
            self
        }
    }
}
