//
//  ResourceViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/5/23.
//

import Foundation

struct ResourceViewModel: Hashable, Identifiable {
    let id: String
    private let title: String
    let description: String
    let index: Int
    private let url: URL?
    private var link: String?
    
    var linkTitle: String {
        link ?? title
    }
    
    init(
        title: String,
        description: String,
        index: Int,
        url: URL?
    ) {
        id = title
        self.title = title
        self.description = description
        self.index = index
        self.url = url
        
        if let url {
            link = "[\(title)](\(url.absoluteString))"
        }
    }
}
