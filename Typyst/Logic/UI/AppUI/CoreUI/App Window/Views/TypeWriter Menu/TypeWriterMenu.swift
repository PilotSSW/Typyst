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
            ScrollView(showsIndicators: false) {
                Spacer()
                    .frame(height: 8)
                VStack(spacing: 16) {
                    ForEach(options, id: \.name) { option in
                        TypeWriterCard(optionInfo: option)
                            .layoutPriority(1)
                    }
                }
                Spacer()
                    .frame(height: 8)
            }
            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .inset(by: 8))
            .padding(.top, -8)
        }
        .asParentCard(withColor: AppColor.primaryBackground)
        .frame(minHeight: 500, maxHeight: 1000)
    }
}

struct TypeWriterMenu_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterMenu(options: TypeWriterMenuOptions.typeWriters)
            .frame(width: 250, height: 650, alignment: .center)
    }
}


