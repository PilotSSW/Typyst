//
//  RoyalModelPBackground.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 8/13/21.
//

import Foundation
import SwiftUI

struct RoyalModelPBackground: View {
    var cornerRadius: CGFloat
    
    var body: some View {
        GeometryReader { viewDimensions in
            let size = viewDimensions.size
            let height = size.height
            let width = size.width
            let magicRatio: CGFloat = (min(height, width) / max(height, width))
            
            ZStack() {
                Rectangle()
                    .fill(TypeWriterColor.RoyalModelP.background1)
                
                VStack(spacing: height / 16) {
                    RadialGradient(gradient:
                        Gradient(colors: [
                            TypeWriterColor.RoyalModelP.background1,
                            TypeWriterColor.RoyalModelP.background3,
                            TypeWriterColor.RoyalModelP.background2,
                            TypeWriterColor.RoyalModelP.background1,
                        ]),
                        center: UnitPoint(x: 0.5, y: ((-500 / height) * (magicRatio * 2.75))),
                        startRadius: magicRatio * 500,
                        endRadius: magicRatio * 1000)
                
                    
                    RadialGradient(gradient:
                        Gradient(colors: [
                            TypeWriterColor.RoyalModelP.background1,
                            TypeWriterColor.RoyalModelP.background3,
                            TypeWriterColor.RoyalModelP.background2,
                            TypeWriterColor.RoyalModelP.background1,
                        ]),
                        center: UnitPoint(x: 0.5, y: ((500 / height) * (magicRatio * 2.75) + 1)),
                        startRadius: magicRatio * 500,
                        endRadius: magicRatio * 1000)
                    
                }
                .opacity(0.9)
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .drawingGroup()
        }
    }
}

struct RoyalModelPBackground_Previews: PreviewProvider {
    static var previews: some View {
        RoyalModelPBackground(cornerRadius: 26)
            .frame(width: 800, height: 375, alignment: .bottom)
    }
}
