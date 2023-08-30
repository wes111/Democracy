//
//  VoteView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 8/29/23.
//

import SwiftUI

struct VoteView: View {
    
    let viewModel: VoteViewModel
    
    var body: some View {
        Text("Vote View")
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Candidates")
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
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewModel.goBack()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.tertiaryText)
                    }
                }
            }
    }
}

//MARK: - Preview
struct VoteView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = VoteViewModel(coordinator: CommunityCoordinator.preview)
        VoteView(viewModel: viewModel)
    }
}
