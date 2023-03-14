//
//  AddPostViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/11/23.
//

import Foundation

protocol AddPostCoordinatorDelegate {
    func go()
}

protocol AddPostViewModelProtocol: ObservableObject {
    var title: String { get set }
    var subtitle: String { get set }
    var body: String { get set }
    var link: String { get set }
    
    func go()
    func submitPost()
}

enum PostField {
    case title, subtitle, body, link, tags
}

final class AddPostViewModel: AddPostViewModelProtocol {
    
    @Published var title = ""
    @Published var subtitle = ""
    @Published var body = ""
    @Published var link = ""
    
    func go() {
    }
    
    func submitPost() {
        print("Submit")
    }
    
}
