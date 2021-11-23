//
//  SmithCoronaSilentBackground.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 8/21/21.
//

import SwiftUI

struct OlympiaSM3Background: View {
    var cornerRadius: CGFloat

    var body: some View {
        GeometryReader { viewDimensions in
            let size = viewDimensions.size
            let height = size.height
            let width = size.width
            let magicRatio: CGFloat = (min(height, width) / max(height, width))

            ZStack() {
                Rectangle()
                    .fill(TypeWriterColor.OlympiaSM3.background1)

                VStack(spacing: height / 16) {
                    RadialGradient(gradient:
                                    Gradient(colors: [
                                        TypeWriterColor.OlympiaSM3.background1,
                                        TypeWriterColor.OlympiaSM3.background2,
                                        TypeWriterColor.OlympiaSM3.background3,
                                        TypeWriterColor.OlympiaSM3.background1,
                                    ]),
                                   center: UnitPoint(x: 0.5, y: ((-500 / height) * (magicRatio * 2.75))),
                                   startRadius: magicRatio * 500,
                                   endRadius: magicRatio * 850)


                    RadialGradient(gradient:
                                    Gradient(colors: [
                                        TypeWriterColor.OlympiaSM3.background1,
                                        TypeWriterColor.OlympiaSM3.background2,
                                        TypeWriterColor.OlympiaSM3.background3,
                                        TypeWriterColor.OlympiaSM3.background1,
                                    ]),
                                   center: UnitPoint(x: 0.5, y: ((500 / height) * (magicRatio * 2.75) + 1)),
                                   startRadius: magicRatio * 550,
                                   endRadius: magicRatio * 850)

                }
                .opacity(0.8)
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .drawingGroup()
        }
    }
}

struct OlympiaSM3Background_Previews: PreviewProvider {
    static var previews: some View {
        OlympiaSM3Background(cornerRadius: 24)
            .frame(width: 800, height: 375, alignment: .bottom)
    }
}
