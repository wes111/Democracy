//
//  String+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/19/23.
//

import Foundation

extension String {
    
    func sanitize() -> String {
        self
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .sanitizeHTML()
            
    }
    
    func sanitizeHTML() -> String {
        self
            .replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    // https://forums.developer.apple.com/forums/thread/682957
    func toAttributedString() -> AttributedString {
        (try? AttributedString(
            markdown: self,
            options: AttributedString.MarkdownParsingOptions(
                interpretedSyntax: .inlineOnlyPreservingWhitespace
            )
        )) ?? .init()
    }
}
