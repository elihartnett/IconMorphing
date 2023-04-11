//
//  MorphingView.swift
//  IconMorphing
//
//  Created by Eli Hartnett on 4/11/23.
//

import SwiftUI

struct MorphingView: View {
    
    @State var currentImage: MorphingImage = .cloud
    @State var pickerImage: MorphingImage = .cloud
    @State var blurRadius: CGFloat = 0
    @State var animate = false
    
    var body: some View {
        
        VStack {
            
            Canvas { context, size in
                
                context.addFilter(.alphaThreshold(min: 0.5))
                context.addFilter(.blur(radius: blurRadius >= 20 ? 20 - (blurRadius - 20) : blurRadius))
                
                context.drawLayer { ctx in
                    if let resolvedImage = context.resolveSymbol(id: 1) {
                        ctx.draw(resolvedImage, at: CGPoint(x: size.width / 2, y: size.height / 2), anchor: .center)
                    }
                }
            } symbols: {
                ResolvedImage(image: $currentImage)
                    .tag(1)
            }
            .onReceive(Timer.publish(every: 0.007, on: .main, in: .common).autoconnect()) { _ in
                if animate {
                    if blurRadius <= 40 {
                        blurRadius += 0.5
                        
                        if blurRadius.rounded() == 20 {
                            currentImage = pickerImage
                        }
                    }
                    if blurRadius.rounded() == 40 {
                        animate = false
                        blurRadius = 0
                    }
                }
            }
            
            Picker("", selection: $pickerImage) {
                ForEach(MorphingImage.allCases, id: \.rawValue) { shape in
                    Image(systemName: shape.rawValue)
                        .tag(shape)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .onChange(of: pickerImage) { _ in
                animate = true
            }
        }
    }
}

struct MorphingView_Previews: PreviewProvider {
    static var previews: some View {
        MorphingView()
    }
}
