//
//  TypeWriterMenu.swift
//  Typyst
//
//  Created by Sean Wolford on 2/23/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct TypeWriterMenu: View {
    var options: [TypeWriterMenuOption]
    var body: some View {
        CardView(cardBackgroundColor: AppColor.typeWriterMenuBackground,
            contentView: AnyView(
                VStack(alignment: .center) {
                    Spacer(minLength: 12)
                    TypeWriterMenuHeader()
                    ForEach(options, id: \.name) { option in
                        TypeWriterCard(optionInfo: option)
                            .frame(alignment: .center)
                    }
                    Spacer(minLength: 24)
                })
        )
    }
}

struct TypeWriterMenu_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterMenu(options: TypeWriterMenuOptions.typeWriters)
    }
}


