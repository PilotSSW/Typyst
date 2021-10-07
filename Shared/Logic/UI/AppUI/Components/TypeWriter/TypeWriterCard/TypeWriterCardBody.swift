//
// Created by Sean Wolford on 3/8/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct TypeWriterCardBody: View {
    @State var showAllText: Bool = false
    var description: String = ""

    var body: some View {
        VStack {
            Text(description)
                .asStyledText(lineLimit: showAllText ? nil : 5)
                .padding(.horizontal, 4)

            Button(action: {
                showAllText = !showAllText
            }) {
                Text(showAllText ? "Hide" : "Show more")
                    .asStyledText(with: .footnote)
                    .frame(minWidth: 55, maxWidth: .infinity,
                           alignment: .center)
            }
            .buttonStyle(NeumorphicButtonStyle(
                backgroundColor: showAllText
                    ? AppColor.buttonTertiary
                    : AppColor.buttonOvertone))
        }
        .animation(.easeOut(duration: 0.15))
    }
}
