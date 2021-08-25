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
            TypeWriterCardHeader(
                maker: optionInfo.model.maker,
                model: optionInfo.model.model,
                modelName: optionInfo.model.name,
                onClick: optionInfo.onClick)
                .layoutPriority(3)
                .zIndex(3)

            TypeWriterImageButton(onClick: optionInfo.onClick,
                                  typeWriterModel: optionInfo.modelType)
                .padding(.top, -8)
                .padding(.horizontal, 8)
                .layoutPriority(2)
                .zIndex(1)

            Spacer()
                .frame(height: 8)
                .layoutPriority(4)

            if let description = optionInfo.model.description {
                Divider()
                    .padding(.horizontal, 24)
                    .zIndex(2)

                TypeWriterCardBody(description: description)
                    .layoutPriority(1)
                    .zIndex(2)

                Spacer()
                    .frame(height: 8)
                    .layoutPriority(4)
            }
        })
        .clipped(antialiased: true)
        .asChildCard(withColor: AppColor.cardTertiaryBackground)
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

