//
//  TypeWriterMenuScrollableSelector.swift
//  Typyst
//
//  Created by Sean Wolford on 3/28/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct TypeWriterMenuScrollableSelector: View {
    var options: TypeWriterMenuOptions

    var body: some View {
        ScrollView(showsIndicators: false) {
            Spacer()
                .frame(height: 4)
            VStack(spacing: 12) {
                ForEach(Array(options.typeWriters.enumerated()), id: \.offset) { (index, option) in
                    TypeWriterCard(optionInfo: option)
                        .padding(.horizontal, 4)
                        .layoutPriority(Double(options.typeWriters.count - index))
                }
            }
            Spacer()
                .frame(height: 4)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous).inset(by: 4))
        .asScrollableCard(withColor: AppColor.cardSecondaryBackground)
    }
}

struct TypeWriterMenuScrollableSelector_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterMenuScrollableSelector(options: TypeWriterMenuOptions())
    }
}
