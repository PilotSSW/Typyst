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
                    .font(.title3)
                    .shadow(color: AppColor.textShadow,
                            radius: 4)
            }
        }
        .buttonStyle(GradientButtonStyle(primaryColor: AppColor.buttonSecondary,
                                         secondaryColor: AppColor.buttonPrimary))
        .accentColor(AppColor.buttonPrimary)
//        .frame(alignment: .center)
        .padding(6)
        .shadow(color: AppColor.objectShadow,
                radius: 4)
    }
}

struct EmailButton_Previews: PreviewProvider {
    static var previews: some View {
        EmailButton()
    }
}
