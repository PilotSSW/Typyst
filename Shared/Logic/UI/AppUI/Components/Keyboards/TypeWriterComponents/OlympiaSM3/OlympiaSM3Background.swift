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
                                   startRadius: magicRatio * 300,
                                   endRadius: magicRatio * 800)


                    RadialGradient(gradient:
                                    Gradient(colors: [
                                        TypeWriterColor.SmithCoronaSilent.background1,
                                        TypeWriterColor.SmithCoronaSilent.background2,
                                        TypeWriterColor.SmithCoronaSilent.background3,
                                        TypeWriterColor.SmithCoronaSilent.background1,
                                    ]),
                                   center: UnitPoint(x: 0.5, y: ((500 / height) * (magicRatio * 2.75) + 1)),
                                   startRadius: magicRatio * 300,
                                   endRadius: magicRatio * 800)

                }
                .opacity(0.66)
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .drawingGroup()
        }
    }
}

struct OlympiaSM3Background_Previews: PreviewProvider {
    static var previews: some View {
        OlympiaSM3Background(cornerRadius: 26)
            .previewDevice("iPad Air (4th generation)")
            .frame(width: 375, height: 110, alignment: .bottom)
    }
}
