//
//  LinkProviderViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/27/24.
//

import Foundation
import LinkPresentation
import SwiftUI
import UniformTypeIdentifiers

@MainActor @Observable
final class LinkProviderViewModel {
    var image: UIImage?
    var title: String?
    var url: String?
    let previewUrl: URL
    
    init(_ previewUrl: URL) {
        self.previewUrl = previewUrl
    }
    func fetchMetadata() async {
        let provider = LPMetadataProvider()
        
        do {
            let metadata = try await provider.startFetchingMetadata(for: previewUrl)
            image = try await convertToImage(metadata.imageProvider)
            title = metadata.title
            url = metadata.url?.host()
        } catch {
            print(error)
        }
    }
    
    private func convertToImage(_ imageProvider: NSItemProvider?) async throws -> UIImage? {
        var image: UIImage?
        
        if let imageProvider {
            let type = String(describing: UTType.image)
            
            if imageProvider.hasItemConformingToTypeIdentifier(type) {
                let item = try await imageProvider.loadItem(forTypeIdentifier: type)
                
                if item is UIImage {
                    image = item as? UIImage
                } else if let url = item as? URL, let data = try? Data(contentsOf: url) {
                    image = UIImage(data: data)
                } else if let data = item as? Data {
                    image = UIImage(data: data)
                }
            }
        }
        return image
    }
}
