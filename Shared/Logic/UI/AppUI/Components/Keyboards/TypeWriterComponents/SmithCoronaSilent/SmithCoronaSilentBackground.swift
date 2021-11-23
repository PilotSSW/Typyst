//
//  SmithCoronaSilentBackground.swift
//  Typyst
//
//  Created by Sean Wolford on 11/23/21.
//

import SwiftUI

struct SmithCoronaSilentBackground: View {
    var cornerRadius: CGFloat

    var body: some View {
        GeometryReader { viewDimensions in
            let size = viewDimensions.size
            let height = size.height
            let width = size.width
            let magicRatio: CGFloat = (min(height, width) / max(height, width))
            
            ZStack() {
                Rectangle()
                    .fill(TypeWriterColor.SmithCoronaSilent.background1)
                
                VStack(spacing: height / 16) {
                    RadialGradient(gradient:
                                    Gradient(colors: [
                                        TypeWriterColor.SmithCoronaSilent.background1,
                                        TypeWriterColor.SmithCoronaSilent.background2,
                                        TypeWriterColor.SmithCoronaSilent.background3,
                                        TypeWriterColor.SmithCoronaSilent.background1,
                                    ]),
                                   center: UnitPoint(x: 0.5, y: ((-500 / height) * (magicRatio * 2.75))),
                                   startRadius: magicRatio * 500,
                                   endRadius: magicRatio * 850)
                    
                    
                    RadialGradient(gradient:
                                    Gradient(colors: [
                                        TypeWriterColor.SmithCoronaSilent.background1,
                                        TypeWriterColor.SmithCoronaSilent.background2,
                                        TypeWriterColor.SmithCoronaSilent.background3,
                                        TypeWriterColor.SmithCoronaSilent.background1,
                                    ]),
                                   center: UnitPoint(x: 0.5, y: ((500 / height) * (magicRatio * 2.75) + 1)),
                                   startRadius: magicRatio * 500,
                                   endRadius: magicRatio * 850)
                    
                }
                .opacity(0.75)
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .drawingGroup()
        }
    }
}

struct SmithCoronaSilentBackground_Previews: PreviewProvider {
    static var previews: some View {
        SmithCoronaSilentBackground(cornerRadius: 24)
    }
}
