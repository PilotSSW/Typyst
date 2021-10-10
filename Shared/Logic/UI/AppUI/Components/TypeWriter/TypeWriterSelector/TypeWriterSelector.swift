//
//  TypeWriterSelector.swift
//  Typyst
//
//  Created by Sean Wolford on 8/3/21.
//

import SwiftUI

struct TypeWriterSelector: View {
    var typeWriterService: TypeWriterService {
        RootDependencyContainer.get().typeWriterService
    }
    var options: TypeWriterMenuOptions
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Array(options.typeWriters.enumerated()), id: \.offset) { (index, option) in
                    TypeWriterImageButton(onClick: option.onClick,
                                          optionInfo: option,
                                          imageSize: .small,
                                          showBlurredImage: false)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

struct TypeWriterSelector_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterSelector(options: TypeWriterMenuOptions())
            .previewLayout(.fixed(width: 325, height: 300.0))
    }
}
