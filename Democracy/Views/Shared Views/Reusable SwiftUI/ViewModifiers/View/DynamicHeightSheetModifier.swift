//
//  DynamicHeightSheetModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/17/24.
//

import SwiftUI

struct DynamicHeightSheetModifier<SheetContent: View>: ViewModifier {
    @State private var height: CGFloat = .zero
    @Binding var isShowingSheet: Bool
    
    private let sheetContent: () -> SheetContent
    
    init(isShowingSheet: Binding<Bool>, @ViewBuilder sheetContent: @escaping () -> SheetContent) {
        self._isShowingSheet = isShowingSheet
        self.sheetContent = sheetContent
    }
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isShowingSheet) {
                ZStack {
                    Color.sheetBackground.ignoresSafeArea(.all)
                    
                    sheetContent()
                        .overlay {
                            GeometryReader { proxy in
                                Color.clear
                                    .task(id: proxy.size.height) {
                                        withAnimation {
                                            $height.wrappedValue = max(proxy.size.height, 0)
                                        }
                                    }
                            }
                        }
                        .presentationDetents([.height(height)])
                }
            }
    }
}

// MARK: - View Extension
extension View {
    func dynamicHeightSheet<SheetContent>(
        isShowingSheet: Binding<Bool>,
        @ViewBuilder sheetContent: @escaping () -> SheetContent
    ) -> some View where SheetContent: View {
        self
            .modifier(DynamicHeightSheetModifier(isShowingSheet: isShowingSheet, sheetContent: sheetContent))
    }
    
    func dynamicHeightSheet<SheetContent, Item>(
        item: Binding<Item?>,
        @ViewBuilder sheetContent: @escaping () -> SheetContent
    ) -> some View where Item: Identifiable, SheetContent: View {
        self
            .modifier(DynamicHeightSheetModifier(
                isShowingSheet: item.mappedToBool(),
                sheetContent: sheetContent)
            )
    }
}

// MARK: - Preview
#Preview {
    @State var showSheet: Bool = false
    
    return ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        Button {
            showSheet = true
        } label: {
            Image(systemName: SystemImage.chevronLeft.rawValue)
        }
        .dynamicHeightSheet(isShowingSheet: $showSheet) {
            VStack {
                Text("Hello")
                Spacer().frame(height: 50)
                Text("Hello World")
                Spacer().frame(height: 50)
                Text("World")
            }
            .foregroundStyle(Color.primaryText)
        }
    }
}
