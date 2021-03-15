//
//  TypeWriterCard.swift
//  Typyst
//
//  Created by Sean Wolford on 2/23/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct TypeWriterCard: View {
    var optionInfo: TypeWriterMenuOption

    var body: some View {
        VStack(alignment: .center, content: {
            Spacer(minLength: 12)
            TypeWriterCardHeader(infoURL: optionInfo.infoURL,
                                 maker: optionInfo.maker,
                                 model: optionInfo.model,
                                 modelName: optionInfo.name)

            TypeWriterImageButton(onClick: optionInfo.onClick,
                                  imagePath: optionInfo.image)
            TypeWriterCardBody(description: optionInfo.description)
            Spacer(minLength: 12)
        })
        .asChildCard(withColor: AppColor.secondaryBackground)
    }
}

struct TypeWriterCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            ForEach(TypeWriterMenuOptions.typeWriters, id: \.name) { optionInfo in
                TypeWriterCard(optionInfo: optionInfo)
            }
        })
        .previewLayout(.sizeThatFits)
    }
}

