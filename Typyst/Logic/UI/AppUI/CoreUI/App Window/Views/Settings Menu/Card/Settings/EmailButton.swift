//
//  EmailButton.swift
//  Typyst
//
//  Created by Sean Wolford on 3/13/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct EmailButton: View {
    var body: some View {
        Button(action: {
            App.instance.emailSupport()
        }) {
            HStack(spacing: 4) {
                Image(systemName: "mail")
                Text("Email Typyst Support")
                    .bold()
                    .asStyledText(with: .title3)
            }
            .padding(.horizontal, 8)
        }
//        .buttonStyle(GradientButtonStyle(primaryColor: AppColor.buttonSecondary,
//                                         secondaryColor: AppColor.buttonPrimary))
        .buttonStyle(NeumorphicButtonStyle(backgroundColor: AppColor.buttonTertiary))
//        .overlay(RoundedRectangle(cornerRadius: 24, style: .continuous)
//                 .strokeBorder(AppColor.buttonBorder, lineWidth:3.0, antialiased: true))
//        .padding(6)
//        .shadow(color: AppColor.objectShadowDark,
//                radius: 4)
    }
}

struct EmailButton_Previews: PreviewProvider {
    static var previews: some View {
        EmailButton()
    }
}
