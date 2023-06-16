//
//  PostCategory+Extension.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/12/23.
//

import Foundation

extension CommunityCategory {
    
    static let preview = CommunityCategory(
        id: UUID(),
        name: "Preview Category",
        imageName: "ben",
        postCount: 50
    )
    
    static let previewArray: [CommunityCategory] = {
        let imageNames = ["ben", "city", "stl", "kc", "sun"]
        var array: [CommunityCategory] = []
        (1...25).forEach { int in
            array.append(
                .init(
                    id: UUID(),
                    name: "Preview Category \(int)",
                    imageName: imageNames.randomElement()!,
                    postCount: int * 2)
            )
        }
        return array
    }()
}
