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
        CardView(cardBackgroundColor: AppColor.typeWriterCardBodyBackground,
                 contentView: AnyView (
                    VStack(alignment: .center, content: {
                        Spacer(minLength: 12)
                        TypeWriterCardHeader(infoURL: optionInfo.infoURL,
                                             maker: optionInfo.maker,
                                             model: optionInfo.model,
                                             modelName: optionInfo.name)
                        Spacer(minLength: 2)
                        TypeWriterImageButton(onClick: optionInfo.onClick,
                                              imagePath: optionInfo.image)
                        Spacer(minLength: 2)
                        TypeWriterCardBody(description: optionInfo.description)
                        Spacer(minLength: 12)
                    })
                    .aspectRatio(contentMode: .fill)
                 )
        )
    }
}

struct TypeWriterCard_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterCard(optionInfo: TypeWriterMenuOptions.modelP)
    }
}

