//
//  CreatePostTitleView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct PostTitleView: UserInputView {
    @ObservedObject var viewModel: PostTitleViewModel
    @FocusState private var focusedField: SubmitPostField?
    
    init(viewModel: PostTitleViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        main
            .onAppear {
                focusedField = viewModel.field
            }
            .onTapGesture {
                focusedField = nil
            }
    }
}

extension PostTitleView {
    
    var field: some View {
        TextField(
            "Title",
            text: $viewModel.text,
            prompt: Text("Title").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(TitleTextFieldStyle(title: $viewModel.text))
        .focused($focusedField, equals: viewModel.field)
        .submitLabel(.next)
        .onTapGesture {
            focusedField = .title
        }
    }
    
    var isShowingProgress: Binding<Bool> {
        $viewModel.isShowingProgress
    }
    
    var onboardingAlert: Binding<OnboardingAlert?> {
        $viewModel.onboardingAlert
    }
}

//    var subtitleField: some View {
//        TextField(
//            "Subtitle",
//            text: $viewModel.subtitle,
//            prompt: Text("Subtitle").foregroundColor(.tertiaryBackground)
//            )
//        .textFieldStyle(TitleTextFieldStyle(title: $viewModel.title))
//        .titledElement(title: "Create a subtitle for your post.")
//    }
//    
//    var bodyField: some View {
//        TextEditor(text: $viewModel.body)
//            .defaultStyle()
//            .titledElement(title: "Add text content to your post.")
//    }
//    
//    var submitButton: some View {
//        AsyncButton(
//            action: {
//                await viewModel.submitPost()
//            },
//            label: {
//                Text("Submit")
//            },
//            showProgressView: $viewModel.isLoading
//        )
//        .buttonStyle(PrimaryButtonStyle())
//    }

// MARK: - Preview
#Preview {
    let viewModel = PostTitleViewModel(coordinator: SubmitPostCoordinator.preview)
    return PostTitleView(viewModel: viewModel)
}
