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
        VStack(alignment: .center, spacing: 6) {
            TypeWriterCardHeader(
                maker: optionInfo.model.maker,
                model: optionInfo.model.model,
                modelName: optionInfo.model.name,
                onClick: optionInfo.onClick)

            TypeWriterImageButton(onClick: optionInfo.onClick,
                                  typeWriterModel: optionInfo.modelType)

            if let description = optionInfo.model.description {
                Divider()
                    .padding(.horizontal, 24)

                TypeWriterCardBody(description: description)
            }
        }
        .padding(6)
        .frame(minHeight: 250, maxHeight: .infinity)
        .asChildCard(withColor: AppColor.cardSecondaryBackground)
    }
}

struct TypeWriterCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            ForEach(TypeWriterMenuOptions().typeWriters, id: \.model.name) { optionInfo in
                TypeWriterCard(optionInfo: optionInfo)
            }
        })
        .previewLayout(.sizeThatFits)
    }
}

