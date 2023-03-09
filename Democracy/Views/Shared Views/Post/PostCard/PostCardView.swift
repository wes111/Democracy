//
//  PostCardView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/8/23.
//

import SwiftUI

struct PostCardView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Post Card view")
                Spacer()
            }
        }
        .foregroundColor(.white)
        .padding(10)
        .padding(.bottom, 50)
        .background(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
    }
}

struct PostCardView_Previews: PreviewProvider {
    static var previews: some View {
        PostCardView()
    }
}
