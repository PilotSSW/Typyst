//
// Created by Sean Wolford on 3/8/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct TypeWriterCardBody: View {
    var description: String = ""
    
    @State var compressTextBody: Bool = true
    @State var showAllText: Bool = false

    var body: some View {
        VStack {
            Text(description)
                .asStyledText(textSize: compressTextBody
                                  ? TextSize.normal.rawValue
                                  : TextSize.veryLarge.rawValue,
                              lineLimit: compressTextBody && !showAllText ? 5 : nil)
                .multilineTextAlignment(.leading)
                .lineSpacing(TextSize.veryLarge.rawValue)
                .padding(.horizontal, 4)

            if compressTextBody {
                Button(action: {
                    showAllText = !showAllText
                }) {
                    Text(showAllText ? "Hide" : "Show more")
                        .asStyledText(with: .title)
                        .frame(minWidth: 55, maxWidth: .infinity,
                               alignment: .center)
                        .padding(8)
                }
                .buttonStyle(NeumorphicButtonStyle(
                    backgroundColor: showAllText
                        ? AppColor.buttonTertiary
                        : AppColor.buttonOvertone))
            }
        }
        .animation(.interactiveSpring())
    }
}
