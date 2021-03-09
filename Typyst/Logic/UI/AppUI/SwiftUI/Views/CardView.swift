//
//  CardView.swift
//  Typyst
//
//  Created by Sean Wolford on 3/8/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct CardView: View {
    let cardBackgroundColor: Color
    let contentView: AnyView

    var body: some View {
        ZStack(alignment: .center, content: {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(cardBackgroundColor)
                .opacity(0.9)

            contentView
        })
        .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
        .shadow(color: AppColor.objectShadow, radius: 10, x: 0, y: 0)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(cardBackgroundColor: AppColor.typeWriterCardBodyBackground,
                 contentView: AnyView(Text("Hello")))
    }
}
