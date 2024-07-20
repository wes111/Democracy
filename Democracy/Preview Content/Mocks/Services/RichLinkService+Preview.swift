//
//  RichLinkService+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/20/24.
//

import Foundation
import LinkPresentation

final class RichLinkServiceMock: RichLinkServiceProtocol {
    
}

// MARK: - Methods
extension RichLinkServiceMock {
    
    func getMetadata(for url: URL) async throws -> LPLinkMetadata {
        .init()
    }
}
