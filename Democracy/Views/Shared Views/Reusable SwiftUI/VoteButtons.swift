//
//  VoteButtons.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/28/24.
//

import SharedResourcesClientAndServer
import SwiftUI

struct VoteButtons: View {
    private let didTapVoteButton: (VoteType) -> Void
    private var upVoteCount: Int
    private var downVoteCount: Int
    
    init(didTapVoteButton: @escaping (VoteType) -> Void, upVoteCount: Int, downVoteCount: Int) {
        self.didTapVoteButton = didTapVoteButton
        self.upVoteCount = upVoteCount
        self.downVoteCount = downVoteCount
    }
    
    var body: some View {
        content
    }
}

// MARK: - Subviews
private extension VoteButtons {
    
    var content: some View {
        HStack(alignment: .center, spacing: ViewConstants.elementSpacing) {
            upVoteButton
            downVoteButton
        }
        .font(.footnote)
        .foregroundStyle(Color.secondaryText)
    }
    
    var upVoteButton: some View {
        Button {
            didTapVoteButton(.up)
        } label: {
            Label {
                Text("\(upVoteCount)")
            } icon: {
                Image(systemName: SystemImage.arrowshapeUp.rawValue)
            }
            .labelStyle(TightLabelStyle())
        }
        .buttonStyle(.plain)
    }
    
    var downVoteButton: some View {
        Button {
            didTapVoteButton(.down)
        } label: {
            Label {
                Text("\(downVoteCount)")
            } icon: {
                Image(systemName: SystemImage.arrowshapeDown.rawValue)
            }
            .labelStyle(TightLabelStyle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        VoteButtons(
            didTapVoteButton: { _ in print("Did Tap Vote Button") },
            upVoteCount: 5,
            downVoteCount: 10
        )
    }
}
