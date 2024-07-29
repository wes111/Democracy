//
//  String+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/19/23.
//

import Foundation
import UIKit

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
    
    func width(font: UIFont) -> CGFloat {
        let constraintRectangle = CGSize(width: .greatestFiniteMagnitude, height: 0.0)
        let boundingBox = self.boundingRect(
            with: constraintRectangle,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )
        return ceil(boundingBox.width)
    }
}
