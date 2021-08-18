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
        switch(typeWriterModel) {
        case .Royal_Model_P: return RoyalModelPBackground(cornerRadius: cornerRadius)
        default: return RoyalModelPBackground(cornerRadius: cornerRadius)
        }
    }
}

struct TypeWriterBackground_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterBackground(typeWriterModel: .Royal_Model_P)
    }
}
