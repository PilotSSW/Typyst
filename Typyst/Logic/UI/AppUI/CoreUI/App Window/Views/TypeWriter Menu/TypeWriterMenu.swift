//
//  TypeWriterMenu.swift
//  Typyst
//
//  Created by Sean Wolford on 2/23/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct TypeWriterMenu: View {
    var body: some View {
        VStack(alignment: .center) {
            TypeWriterMenuHeader()
            TypeWriterMenuScrollableSelector(options: TypeWriterMenuOptions.typeWriters)
                .padding(.bottom, 8)
        }
        .asParentCard(withColor: AppColor.cardPrimaryBackground)
        .frame(minHeight: 280, maxHeight: 550)
    }
}

struct TypeWriterMenu_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterMenu()
            .frame(width: 250, height: 650, alignment: .center)
    }
}


