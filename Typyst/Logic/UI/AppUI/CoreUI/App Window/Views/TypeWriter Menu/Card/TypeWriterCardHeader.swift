//
// Created by Sean Wolford on 3/8/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

struct TypeWriterCardHeader: View {
    var infoURL: URL
    var maker: String
    var model: TypeWriter.Model
    var modelName: String

    @ObservedObject
    var appSettings: AppSettings = AppSettings.shared

    var isSelected: Bool {
        $appSettings.selectedTypewriter.wrappedValue == model.rawValue
    }

    var body: some View {
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
            .frame(width: 185)
            .asStyledCardHeader(withBackgroundColor: isSelected
                ? AppColor.buttonPrimary
                : AppColor.typeWriterCardHeaderBackground)
        }
    }
}

struct TypeWriterCardHeader_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterCardHeader(infoURL: URL(string: "www.google.com")!,
                             maker: "Smith-Corona",
                             model: .Smith_Corona_Silent,
                             modelName: "Silent")
    }
}
