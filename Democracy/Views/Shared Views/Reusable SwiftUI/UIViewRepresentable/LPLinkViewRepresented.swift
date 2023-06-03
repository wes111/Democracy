//
//  LPLinkViewRepresented.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/3/23.
//

import Foundation
import LinkPresentation
import SwiftUI

struct LPLinkViewRepresented: UIViewRepresentable {
    
    var metadata: LPLinkMetadata
    
    func makeUIView(context: Context) -> LPLinkView {
        return LPLinkView(metadata: metadata)
    }
    
    func updateUIView(_ uiView: LPLinkView, context: Context) {
        
    }
}
