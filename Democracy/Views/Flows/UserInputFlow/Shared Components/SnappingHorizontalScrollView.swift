//
//  SnappingHorizontalScrollView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/7/24.
//

import SwiftUI

struct SnappingHorizontalScrollView<T: Hashable, Content: View>: View {
    
    var scrollContent: [T]
    let content: (T) -> Content
    
    init(
        scrollContent: [T],
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self.scrollContent = scrollContent
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geo in
            let ruleWidth = geo.size.width * 0.75
            let ruleHeight: CGFloat = 200
            
            ScrollView(.horizontal) {
                LazyHStack(alignment: .center, spacing: 0) {
                    ForEach(scrollContent, id: \.self) { rule in
                        content(rule)
                            .frame(maxHeight: ruleHeight)
                            .frame(width: ruleWidth)
                            .scrollTransition(.animated.threshold(.visible(0.5))) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0.5)
                                    .scaleEffect(phase.isIdentity ? 1 : 0.8)
                                    .blur(radius: phase.isIdentity ? 0 : 1)
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .animation(.easeOut(duration: ViewConstants.animationLength), value: scrollContent)
            .contentMargins(.horizontal, (geo.size.width - ruleWidth) / 2, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
            .scrollClipDisabled()
            .scrollIndicators(.hidden)
            .frame(maxHeight: min(geo.size.height, ruleHeight))
        }
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        SnappingHorizontalScrollView(scrollContent: Community.preview.rules) { rule in
            RuleView(rule: rule) {
                Button("Delete") { }
                Button("Edit") { }
            }
        }
    }
}
