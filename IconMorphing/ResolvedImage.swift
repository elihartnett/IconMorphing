//
//  ResolvedImage.swift
//  IconMorphing
//
//  Created by Eli Hartnett on 4/11/23.
//

import SwiftUI

struct ResolvedImage: View {
    
    @Binding var image: MorphingImage
    
    var body: some View {
        Image(systemName: image.rawValue)
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
            .animation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8), value: image)
    }
}

struct ResolvedImage_Previews: PreviewProvider {
    static var previews: some View {
        ResolvedImage(image: .constant(MorphingImage.bell))
    }
}
