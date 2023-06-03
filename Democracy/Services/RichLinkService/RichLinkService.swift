//
//  RichLinkService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/3/23.
//

import Combine
import Foundation
import LinkPresentation

protocol RichLinkServiceProtocol {
    func getMetadata(for url: URL) async throws -> LPLinkMetadata
}

final class RichLinkService: RichLinkServiceProtocol {
    
    private var metadataDictionary: [URL: LPLinkMetadata] = [:] /// TODO: more elaborate caching.
    
    func getMetadata(for url: URL) async throws -> LPLinkMetadata {
        
        if let metadata = metadataDictionary[url] {
            return metadata
        } else {
            
            /// Re-create the provider, a one-shot object.
            let provider = LPMetadataProvider()
            
            let metadata = try await provider.startFetchingMetadata(for: url)
            
            metadataDictionary[url] = metadata
            return metadata
        }
    }
}
