//
//  CreatePostTitleView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct PostTitleView: UserInputView {
    var isShowingProgress: Binding<Bool> {
        $viewModel.isShowingProgress
    }
    
    var onboardingAlert: Binding<OnboardingAlert?> {
        $viewModel.onboardingAlert
    }
    
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
    
    var field: some View {
        TextField(
            "Title",
            text: $viewModel.text,
            prompt: Text("Title").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(TitleTextFieldStyle(title: $viewModel.text))
        .titledElement(title: "Create a title for your post.")
    }
    
//    var body: some View {
//        content
//            .background(Color.primaryBackground, ignoresSafeAreaEdges: .all)
//            .toolbarNavigation(
//                trailingButtons: viewModel.trailingButtons,
//                centerContent: .title("Create Post")
//            )
//            .onAppear {
//                focusedField = .title
//            }
//            .onSubmit {
//                focusedField = getNextField(after: focusedField)
//            }
//            .alert(item: $viewModel.alert) { alert in
//                Alert(title: Text(alert.title), message: Text(alert.message), dismissButton: .cancel())
//            }
//    }
    
    func getNextField(after field: SubmitPostField?) -> SubmitPostField? {
        guard let field = field else {
            return nil
        }
        switch field {
        case .title: return .body
        case .body: return .link
        case .link: return nil
        case .tags: return nil
        }
    }
}

// MARK: - Subviews
private extension PostTitleView {
    
//    var content: some View {
//        NavigationStack {
//            ZStack {
//                ScrollView {
//                    VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
//                        titleField
//                        subtitleField
//                        bodyField
//                        submitButton
//                    }
//                    .padding()
//                }
//                
//                if viewModel.isLoading {
//                    ProgressView()
//                }
//            }
//        }
//    }
    
//    var titleField: some View {
//        TextField(
//            "Title",
//            text: $viewModel.title,
//            prompt: Text("Title").foregroundColor(.tertiaryBackground)
//            )
//        .textFieldStyle(TitleTextFieldStyle(title: $viewModel.title))
//        .titledElement(title: "Create a title for your post.")
//    }
    
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
}

// MARK: - Preview
#Preview {
    let viewModel = PostTitleViewModel(coordinator: SubmitPostCoordinator.preview)
    return PostTitleView(viewModel: viewModel)
}
