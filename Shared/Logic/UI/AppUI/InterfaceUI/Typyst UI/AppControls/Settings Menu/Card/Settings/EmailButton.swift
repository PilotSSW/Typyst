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
            appDependencyContainer.emailHandler.emailDeveloper()
        }) {
            HStack(spacing: 4) {
                Image(systemName: "mail")
                Text("Email Typyst Support")
                    .bold()
                    .asStyledText(with: .title3)
            }
            .padding(.horizontal, 8)
        }
        .buttonStyle(NeumorphicButtonStyle(backgroundColor: AppColor.buttonSecondary))
    }
}

struct EmailButton_Previews: PreviewProvider {
    static var previews: some View {
        EmailButton()
    }
}
