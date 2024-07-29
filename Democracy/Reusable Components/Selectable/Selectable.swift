//
//  Selectable.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/5/24.
//

import Foundation

// A type that presents the user with a set of selectable options.
protocol Selectable: Hashable, Identifiable, CaseIterable where AllCases == [Self] {
    var title: String { get }
    var subtitle: String? { get }
    var image: SystemImage? { get }
    
    static var metaTitle: String { get }
    static var metaImage: SystemImage { get }
}

extension Selectable {
    public var id: String {
        self.title
    }
}
