//
//  TypeWriterMenuScrollableSelector.swift
//  Typyst
//
//  Created by Sean Wolford on 3/28/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct TypeWriterMenuScrollableSelector: View {
    var options: [TypeWriterMenuOption]

    var body: some View {
        ScrollView(showsIndicators: false) {
            Spacer()
                .frame(height: 4)
            VStack(spacing: 8) {
                ForEach(options, id: \.name) { option in
                    TypeWriterCard(optionInfo: option)
                        .padding(.horizontal, 4)
                        .layoutPriority(1)
                }
            }
            Spacer()
                .frame(height: 4)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous).inset(by: 4))
        .asParentCard(withColor: AppColor.cardSecondaryBackground)

//                    .inset(by: 8))
    }
}

struct TypeWriterMenuScrollableSelector_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterMenuScrollableSelector(options: TypeWriterMenuOptions.typeWriters)
    }
}
