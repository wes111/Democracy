//
//  TaggableModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/17/23.
//

import Foundation
import SwiftUI

// A Textfield with a list of entered tags displayed below.
extension TextField {
    
    func taggable(title: String? = nil, tags: [String]) -> some View {
        modifier(TaggableModifier(title: title, tags: tags))
    }
    
    struct TaggableModifier: ViewModifier {
        let title: String?
        let tags: [String]
        
        func body(content: Content) -> some View {
            VStack(alignment: .leading, spacing: 20) {
                content
                
                if !tags.isEmpty {
                    NewFlowLayout(alignment: .leading) {
                        ForEach(tags, id: \.self) { tag in
                            Text(tag)
                                .padding(10)
                                .background(Color.secondaryBackground, in: RoundedRectangle(cornerRadius: 10))
                                .foregroundStyle(Color.secondaryText)
                        }
                    }
                }
            }
            // .standardTextField()
        }
    }
}
