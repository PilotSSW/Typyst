//
//  TypeWriterBackground.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 8/13/21.
//

import SwiftUI

struct TypeWriterBackground: View {
    var typeWriterModel: TypeWriterModel.ModelType
    var cornerRadius: CGFloat = 8.0

    var body: some View {
        backgroundView
            .drawingGroup()
    }
}

extension TypeWriterBackground {
    @ViewBuilder
    private var backgroundView: some View {
        switch(typeWriterModel) {
            case .Olympia_SM3: OlympiaSM3Background(cornerRadius: cornerRadius)
            case .Royal_Model_P: RoyalModelPBackground(cornerRadius: cornerRadius)
            //case .Smith_Corona_Silent: SmithCoronaSilentBackground(cornerRadius: cornerRadius)
            default: NoBackgroundView(cornerRadius: cornerRadius)
        }
    }
}

struct TypeWriterBackground_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterBackground(typeWriterModel: .Smith_Corona_Silent)
    }
}

struct NoBackgroundView: View {
    var cornerRadius: CGFloat = 8.0

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.white.opacity(0.25))
    }
}
