//
//  CommunityLeadersView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI

struct HorizontalSelectableList<T: Selectable>: View {
    
    @Binding var selection: T
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: ViewConstants.smallElementSpacing) {
                ForEach(T.allCases) { option in
                    optionView(option)
                }
            }
        }
    }
    
    func optionView(_ option: T) -> some View {
        return Text(option.title)
            .tagModifier()
            .overlay(
                RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
                    .strokeBorder(
                        selection == option ? Color.tertiaryText : Color.primaryBackground,
                        lineWidth: ViewConstants.thinBorderWidth
                    )
            )
            .onTapGesture {
                selection = option
            }
    }
}

// Text fields of the AddResourceView
enum AddResourceField: Hashable {
    case title, description, url
}

@Observable
final class AddResourceViewModel {
    
    var title: String = ""
    var description: String = ""
    var url: String = ""
    var category: ResourceCategory = .book
}

struct AddResourceView: View {
    @Bindable var viewModel: AddResourceViewModel
    @FocusState private var focusedField: AddResourceField?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .center, spacing: ViewConstants.elementSpacing) {
            Text("Add Resource Sheet")
                .font(.system(.body, weight: .semibold))
                .foregroundStyle(Color.secondaryText)
            
            VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                HorizontalSelectableList(selection: $viewModel.category)
                    .titledElement(title: "Category")
                
                titleField
                    
                urlField
                descriptionField
                Spacer()
                closeButton
            }
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .padding(.top, ViewConstants.partialSheetTopPadding)
        .padding([.horizontal, .bottom], ViewConstants.screenPadding)
        .background(Color.primaryBackground.ignoresSafeArea())
    }
}

// MARK: - Subviews
private extension AddResourceView {
    
    var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Close")
        }
        .buttonStyle(SeconaryButtonStyle())
    }
    
    var titleField: some View {
        DefaultTextInputField(
            text: $viewModel.title,
            textFieldStyle: TitleTextFieldStyle(
                title: $viewModel.title,
                focusedField: $focusedField,
                field: AddResourceField.title
            ),
            fieldTitle: "Title",
            requirementType: DefaultRequirement.self
        )
        .titledElement(title: "Title")
        .onSubmit {
            focusedField = .description
        }
    }
    
    var urlField: some View {
        DefaultTextInputField(
            text: $viewModel.url,
            textFieldStyle: LinkTextFieldStyle(
                link: $viewModel.url,
                focusedField: $focusedField,
                field: .url
            ),
            fieldTitle: "URL",
            requirementType: LinkRequirement.self
        )
        .titledElement(title: "Link")
        .onSubmit {
            focusedField = .description
        }
    }
    
    var descriptionField: some View {
        TextField(
            "Description",
            text: $viewModel.description,
            prompt: Text("Description").foregroundColor(.tertiaryBackground),
            axis: .vertical
        )
        .lineLimit(2...4)
        .requirements(
            text: $viewModel.description,
            requirementType: DefaultRequirement.self
        )
        .textFieldStyle(TitleTextFieldStyle(
            title: $viewModel.description,
            focusedField: $focusedField,
            field: AddResourceField.description
        ))
        .titledElement(title: "Description")
        .onSubmit {
            focusedField = .title
        }
    }
}

@MainActor
struct CommunityResourcesView: View {
    @Bindable var viewModel: CommunityResourcesViewModel
    
    var body: some View {
        UserInputScreen(viewModel: viewModel) {
            primaryContent
        }
        .sheet(isPresented: $viewModel.isShowingAddResourceSheet) {
            addResourceSheet
        }
        .brightness(viewModel.isShowingAddResourceSheet ? ViewConstants.dimmingBrightness : 0.0)
        .animation(.easeInOut, value: viewModel.isShowingAddResourceSheet)
        .onAppear {
            viewModel.onAppear()
        }
    }
}

// MARK: - Subviews
private extension CommunityResourcesView {
    
    var primaryContent: some View {
        VStack {
            addResourceButton
            // TODO: ...
            SnappingHorizontalScrollView(scrollContent: ["hello world"]) { text in
                Text(text)
            }
        }
    }
    
    var addResourceButton: some View {
        Button {
            viewModel.isShowingAddResourceSheet = true
        } label: {
            Text("Add Resource")
        }
        .buttonStyle(SeconaryButtonStyle())
    }
    
    var addResourceSheet: some View {
        AddResourceView(viewModel: .init()) // TODO: ViewModel
            .presentationDetents([
                .fraction(0.8)
            ])
            .presentationDragIndicator(.visible)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityResourcesView(viewModel: .preview)
    }
    
}
