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
        VStack(alignment: .center) {
            Spacer(minLength: 8)
            TypeWriterMenuHeader()
            List {
                ForEach(options, id: \.name) { option in
                    TypeWriterCard(optionInfo: option)
                }
                .background(Color.clear)
                .clipped(antialiased: true)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            }
            .background(Color.clear)
            .clipped(antialiased: true)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))

            Spacer(minLength: 8)
        }
        .asParentCard(withColor: AppColor.primaryBackground)
//        .frame(minHeight: 650)
    }
}

struct TypeWriterMenu_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterMenu(options: TypeWriterMenuOptions.typeWriters)
            .frame(width: 250, height: 650, alignment: .center)
    }
}


