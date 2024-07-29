//
//  NewFlowLayout.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/10/23.
//

import SwiftUI

// https://github.com/apple/sample-food-truck
// https://blog.logrocket.com/implementing-tags-swiftui/
// TODO: Remove this layout. It breaks... and is complicated. Use the simpler implementation below...
struct NewFlowLayout: Layout {
    var alignment: Alignment = .center
    var spacing: CGFloat?
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        let result = FlowResult(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews,
            alignment: alignment,
            spacing: spacing
        )
        return result.bounds
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        let result = FlowResult(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews,
            alignment: alignment,
            spacing: spacing
        )
        for row in result.rows {
            let rowXOffset = (bounds.width - row.frame.width) * alignment.horizontal.percent
            for index in row.range {
                let xPos = rowXOffset + row.frame.minX + row.xOffsets[index - row.range.lowerBound] + bounds.minX
                let rowYAlignment = (row.frame.height - subviews[index].sizeThatFits(.unspecified).height) *
                alignment.vertical.percent
                let yPos = row.frame.minY + rowYAlignment + bounds.minY
                subviews[index].place(at: CGPoint(x: xPos, y: yPos), anchor: .topLeading, proposal: .unspecified)
            }
        }
    }
    
    struct FlowResult {
        var bounds = CGSize.zero
        var rows = [Row]()
        
        struct Row {
            var range: Range<Int>
            var xOffsets: [Double]
            var frame: CGRect
        }
        
        init(in maxPossibleWidth: Double, subviews: Subviews, alignment: Alignment, spacing: CGFloat?) {
            var itemsInRow = 0
            var remainingWidth = maxPossibleWidth.isFinite ? maxPossibleWidth : .greatestFiniteMagnitude
            var rowMinY = 0.0
            var rowHeight = 0.0
            var xOffsets: [Double] = []
            for (index, subview) in zip(subviews.indices, subviews) {
                let idealSize = subview.sizeThatFits(.unspecified)
                if index != 0 && widthInRow(index: index, idealWidth: idealSize.width) > remainingWidth {
                    // Finish the current row without this subview.
                    finalizeRow(index: max(index - 1, 0), idealSize: idealSize)
                }
                addToRow(index: index, idealSize: idealSize)
                
                if index == subviews.count - 1 {
                    // Finish this row; it's either full or we're on the last view anyway.
                    finalizeRow(index: index, idealSize: idealSize)
                }
            }
            
            func spacingBefore(index: Int) -> Double {
                guard itemsInRow > 0 else { return 0 }
                return spacing ?? subviews[index - 1].spacing.distance(to: subviews[index].spacing, along: .horizontal)
            }
            
            func widthInRow(index: Int, idealWidth: Double) -> Double {
                idealWidth + spacingBefore(index: index)
            }
            
            func addToRow(index: Int, idealSize: CGSize) {
                let width = widthInRow(index: index, idealWidth: idealSize.width)
                
                xOffsets.append(maxPossibleWidth - remainingWidth + spacingBefore(index: index))
                // Allocate width to this item (and spacing).
                remainingWidth -= width
                // Ensure the row height is as tall as the tallest item.
                rowHeight = max(rowHeight, idealSize.height)
                // Can fit in this row, add it.
                itemsInRow += 1
            }
            
            func finalizeRow(index: Int, idealSize: CGSize) {
                let rowWidth = maxPossibleWidth - remainingWidth
                rows.append(
                    Row(
                        range: index - max(itemsInRow - 1, 0) ..< index + 1,
                        xOffsets: xOffsets,
                        frame: CGRect(x: 0, y: rowMinY, width: rowWidth, height: rowHeight)
                    )
                )
                bounds.width = max(bounds.width, rowWidth)
                let ySpacing = spacing ?? ViewSpacing().distance(to: ViewSpacing(), along: .vertical)
                bounds.height += rowHeight + (rows.count > 1 ? ySpacing : 0)
                rowMinY += rowHeight + ySpacing
                itemsInRow = 0
                rowHeight = 0
                xOffsets.removeAll()
                remainingWidth = maxPossibleWidth
            }
        }
    }
}

private extension HorizontalAlignment {
    var percent: Double {
        switch self {
        case .leading: return 0
        case .trailing: return 1
        default: return 0.5
        }
    }
}

private extension VerticalAlignment {
    var percent: Double {
        switch self {
        case .top: return 0
        case .bottom: return 1
        default: return 0.5
        }
    }
}

// MARK: - Preview
#Preview {
    // TODO: Use a better (dynamic tags array) example here.
    let tags = ["Cat", "Dog", "Turkey", "Goose", "Elephant", "Monkey", "Lion"]
    return NewFlowLayout {
        ForEach(tags, id: \.self) { tag in
            Text(tag)
        }
    }
    .frame(width: 150)
}

// MARK: -- CollectionView

// Modified from: https://blog.stackademic.com/swiftui-custom-collectionview-ea06c4a6bc70
struct CollectionView: View {
    @State private var itemsArranged: [[String]] = []
    let selectedItems: [String]
    let items: [String]
    let toggleTagAction: (String) -> Void
    
    init(selectedItems: [String], items: [String], toggleTagAction: @escaping (String) -> Void) {
        self.selectedItems = selectedItems
        self.items = items
        self.toggleTagAction = toggleTagAction
    }
    
    private let horizontalSpacing: CGFloat = ViewConstants.smallElementSpacing
    private let horizontalPadding: CGFloat = 16
    private let font: UIFont = UIFont.systemFont(ofSize: 18)

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(0..<itemsArranged.count, id: \.self) { row in
                        let itemsInRow = itemsArranged[row]
                        
                        HStack(spacing: horizontalSpacing) {
                            ForEach(0..<itemsInRow.count, id: \.self) { column in
                                let tag = itemsInRow[column]
                                tagView(
                                    tag,
                                    backgroundColor: selectedItems.contains(tag) ? .otherRed : .onBackground
                                )
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .onAppear {
                    itemsArranged = arrangeItems(items, containerWidth: geometry.size.width)
                }
            }
            .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
        }
    }
    
    func arrangeItems(_ items: [String], containerWidth: CGFloat) -> [[String]] {
        var arrangeItems: [[String]] = []
        var currentRowWidth: CGFloat = 0
        
        for index in 0..<items.count {
            let item = items[index]
            let itemWidth = item.width(font: font) + 16
            
            // first item
            if index == 0 {
                arrangeItems.append([item])
                currentRowWidth = itemWidth
                continue
            }
            
            if currentRowWidth + horizontalSpacing + itemWidth > containerWidth {
                // start new row
                arrangeItems.append([item])
                currentRowWidth = itemWidth
            } else {
                // add to current row
                arrangeItems[arrangeItems.count - 1].append(item)
                currentRowWidth = currentRowWidth + horizontalSpacing + itemWidth
            }
        }
        return arrangeItems
    }
    
    func tagView(_ tag: String, backgroundColor: Color) -> some View {
        HStack(alignment: .center, spacing: ViewConstants.smallElementSpacing) {
            Text(tag)
            
            //            Button {
            //                tapAction()
            //            } label: {
            //                Image(systemName: SystemImage.xCircle.rawValue)
            //            }
        }
        .tagModifier(backgroundColor: backgroundColor)
        .onTapGesture {
            toggleTagAction(tag)
        }
    }
}
