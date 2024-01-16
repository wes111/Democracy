//
//  PostSecondaryLinksView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/8/24.
//

import SwiftUI

struct PostSecondaryLinksView<ViewModel: PostSecondaryLinksViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    @FocusState private var focusedField: SubmitPostField?
    @State private var addedSecondaryLinks: [String] = []
    
    var body: some View {
        UserInputScreen(viewModel: viewModel) {
            todoView
        }
        .onAppear {
            focusedField = viewModel.field
            viewModel.onAppear()
        }
        .onTapGesture {
            focusedField = nil
        }
        .onChange(of: viewModel.addedSecondaryLinks) { _, newValue in
            withAnimation {
                addedSecondaryLinks = newValue
            }
        }
    }
}

// MARK: - Subviews
private extension PostSecondaryLinksView {
    var todoView: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            field
            addLinkButton
            
            ScrollView(showsIndicators: true) {
                VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
                    ForEach(addedSecondaryLinks, id: \.self) { link in
                        addedLinkView(link)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    func addedLinkView(_ link: String) -> some View {
        HStack(alignment: .center, spacing: ViewConstants.smallElementSpacing) {
            Text(link)
                .lineLimit(1)
            
            Button {
                viewModel.removeLink(link)
            } label: {
                Image(systemName: SystemImage.xCircle.rawValue)
            }
        }
        .padding(ViewConstants.smallInnerBorder)
        .background(Color.onBackground, in: RoundedRectangle(cornerRadius: ViewConstants.cornerRadius))
        .foregroundStyle(Color.secondaryText)
    }
    
    var field: some View {
        TextField(
            "Secondary Link",
            text: $viewModel.text,
            prompt: Text("Secondary Link").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(LinkTextFieldStyle(
            link: $viewModel.text,
            focusedField: $focusedField,
            field: .secondaryLinks
        ))
    }
    
    var addLinkButton: some View {
        AsyncButton(
            action: { await viewModel.addLinkToList() },
            label: { Text("Add Link") },
            showProgressView: $viewModel.isShowingProgress
        )
        .buttonStyle(PrimaryButtonStyle())
        .isDisabledWithAnimation(isDisabled: !viewModel.canAddLink)
    }
}

// MARK: - Preview
#Preview {
    let viewModel = PostSecondaryLinksViewModel(
        coordinator: SubmitPostCoordinator.preview,
        submitPostInput: .init()
    )
    return NavigationStack {
        PostSecondaryLinksView(viewModel: viewModel)
    }
        
}
