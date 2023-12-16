//
//  VoteView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 8/29/23.
//

import SwiftUI

struct CandidateListItemViewModel: Identifiable {
    private let dateFormatter = DateFormatter()
    let id = UUID().uuidString
    private var score: Int /// Upvotes - downvotes.
    var upVotes: Int
    var downVotes: Int
    private let memberSince: Date
    let candidateName: String
    let imageName: String
    
    init(
        score: Int,
        upVotes: Int,
        downVotes: Int,
        memberSince: Date,
        candidateName: String,
        imageName: String
    ) {
        self.score = score
        self.upVotes = upVotes
        self.downVotes = downVotes
        self.memberSince = memberSince
        self.candidateName = candidateName
        self.imageName = imageName
        
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
    }
    
    var memberSinceString: String {
        "Since: \(memberSince.formatted(date: .abbreviated, time: .omitted))"
    }
    
    var scoreString: String {
        "Score: \(score)"
    }
}

struct CandidateListItem: View {
    
    let viewModel: CandidateListItemViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(viewModel.imageName)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(maxWidth: 50)
            
            Spacer().frame(width: 10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.candidateName)
                    .font(.system(.body, weight: .semibold))
                    .foregroundColor(.primaryText)
                Text(viewModel.scoreString)
                    .foregroundColor(.tertiaryText)
                    .font(.caption)
                Text(viewModel.memberSinceString)
                    .foregroundColor(.tertiaryText)
                    .font(.caption)
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: "arrow.up")
                    
                    Text("\(viewModel.upVotes)")
                }
                
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: "arrow.down")
                    
                    Text("\(viewModel.downVotes)")
                }
            }
            .foregroundColor(.primaryText)
            .font(.system(.callout, weight: .medium))
        }
        // .padding()
        // .background(Color.secondaryBackground, in: RoundedRectangle(cornerRadius: 15))
    }
}

struct VoteView: View {
    
    @StateObject private var viewModel: VoteViewModel
    
    init(viewModel: VoteViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(viewModel.candidateViewModels) { candidate in
                    CandidateListItem(viewModel: candidate)
                    Divider()
                        .overlay(Color.secondaryText)
                }
            }
        }
        .padding()
        .toolbarNavigation(
            leadingButtons: viewModel.leadingButtons,
            trailingButtons: viewModel.trailingButtons,
            centerContent: .title(viewModel.navigationTitle)
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu("Role") {
                    ForEach(RepresentativeType.allCases) { type in
                        Button {
                            viewModel.role = type
                        } label: {
                            Text(type.rawValue)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    let viewModel = VoteViewModel(coordinator: CommunityCoordinator.preview)
    
    return ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        VoteView(viewModel: viewModel)
    }
}
