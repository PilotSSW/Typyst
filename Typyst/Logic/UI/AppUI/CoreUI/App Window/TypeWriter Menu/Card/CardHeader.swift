//
// Created by Sean Wolford on 3/8/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

struct TypeWriterCardHeader: View {
    @ObservedObject var selectedTypeWriter: TypeWriter = App.instance.core.loadedTypewriter!

    var infoURL: URL
    var maker: String
    var model: TypeWriter.Model
    var modelName: String

    var body: some View {
        ZStack {
            Capsule()
                .fill(selectedTypeWriter.model == model
                      ? AppColor.selectedHeaderBackground
                      : AppColor.typeWriterCardHeaderBackground)
                .frame(width: 212, height: 24)

            Link(destination: infoURL) {
                HStack(content: {
                    Text(maker)
                        .font(.headline)
                        .bold()
                        .foregroundColor(AppColor.textHeader)
                    Text("-")
                        .font(.headline)
                        .bold()
                        .foregroundColor(AppColor.textHeader)
                    Text(modelName)
                        .font(.headline)
                        .bold()
                        .foregroundColor(AppColor.textHeader)
                })
            }
            .shadow(color: AppColor.textShadow, radius: 3, x: 0, y: 0)
        }
    }
}
