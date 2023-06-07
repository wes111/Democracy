//
//  OffsetObservingScrollView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/4/23.
//

import SwiftUI

// https://www.swiftbysundell.com/articles/observing-swiftui-scrollview-content-offset/
struct OffsetObservingScrollView<Content: View>: View {
    
    var axes: Axis.Set = [.vertical]
    var showsIndicators = true
    @Binding var offset: CGPoint
    @ViewBuilder var content: () -> Content

    // The name of our coordinate space doesn't have to be
    // stable between view updates (it just needs to be
    // consistent within this view), so we'll simply use a
    // plain UUID for it:
    private let coordinateSpaceName = UUID()
    
    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            PositionObservingView(
                coordinateSpace: .named(coordinateSpaceName),
                position: Binding(
                    get: { offset },
                    set: { newOffset in
                        offset = CGPoint(
                            x: -newOffset.x,
                            y: -newOffset.y
                        )
                    }
                ),
                content: content
            )
        }
        .coordinateSpace(name: coordinateSpaceName)
    }
}

//struct OffsetObservingScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        OffsetObservingScrollView()
//    }
//}
