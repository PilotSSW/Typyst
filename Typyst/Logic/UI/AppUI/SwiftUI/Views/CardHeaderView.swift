//
//  CardHeaderView.swift
//  Typyst
//
//  Created by Sean Wolford on 3/8/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct CardHeaderView: View {
    var backgroundColor: Color
    var contentView: AnyView

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(backgroundColor)
                .shadow(color: AppColor.objectShadow, radius: 6, x: 0, y: 0)

            contentView
        }
        .frame(height: 32)
        .padding(.all, 12)
    }
}

struct CardHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CardHeaderView(backgroundColor: AppColor.typeWriterCardBodyBackground,
                       contentView: AnyView (
                        Text("Hello")
                       ))
    }
}
