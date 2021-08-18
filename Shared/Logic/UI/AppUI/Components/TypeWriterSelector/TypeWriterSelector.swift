//
//  TypeWriterSelector.swift
//  Typyst
//
//  Created by Sean Wolford on 8/3/21.
//

import SwiftUI

struct TypeWriterSelector: View {
    var options: TypeWriterMenuOptions
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 2) {
                ForEach(Array(options.typeWriters.enumerated()), id: \.offset) { (index, option) in
                    let imagePath = option.model.image
                    Image("TypeWriterTransparencies/\(imagePath ?? "")")
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .padding(4)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous).inset(by: 4))
    }
}

struct TypeWriterSelector_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterSelector(options: TypeWriterMenuOptions())
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/600.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/))
    }
}
