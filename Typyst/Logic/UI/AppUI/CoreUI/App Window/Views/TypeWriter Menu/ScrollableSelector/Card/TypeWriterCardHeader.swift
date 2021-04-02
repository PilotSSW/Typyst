//
// Created by Sean Wolford on 3/8/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

struct TypeWriterCardHeader: View {
//    var infoURL: URL
    var maker: String
    var model: TypeWriterModel.ModelType
    var modelName: String
    var onClick: (() -> Void)? = nil

    @ObservedObject
    var appSettings: AppSettings = AppSettings.shared

    var isSelected: Bool {
        $appSettings.selectedTypewriter.wrappedValue == model.rawValue
    }

    var body: some View {
        Button(action: onClick ?? {}, label: {
            HStack(content: {
                Text(maker)
                    .bold()
                    .asStyledHeader()
                Text("-")
                    .asStyledHeader()
                Text(modelName)
                    .bold()
                    .asStyledHeader()
            })
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .asStyledCardHeader(withBackgroundColor: isSelected
                                    ? AppColor.buttonPrimary
                                    : AppColor.typeWriterCardHeaderBackground)
        })
        .buttonStyle(PlainButtonStyle())
    }
}

struct TypeWriterCardHeader_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterCardHeader(maker: "Smith-Corona",
                             model: .Smith_Corona_Silent,
                             modelName: "Silent")
    }
}
