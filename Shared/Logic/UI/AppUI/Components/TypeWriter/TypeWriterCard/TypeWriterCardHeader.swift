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

    @State
    var showAlert = false

    @ObservedObject
    var settingsService: SettingsService = RootDependencyContainer.get().settingsService

    var isSelected: Bool {
        $settingsService.selectedTypewriter.wrappedValue == model.rawValue
    }

    var body: some View {
        Button(action: {
            onClick?()
        }, label: {
            HStack() {
                Text(maker)
                    .bold()
                Text("-")
                Text(modelName)
                    .bold()
            }
            .asStyledCardHeader(withBackgroundColor: isSelected
                                    ? AppColor.buttonPrimary
                                    : AppColor.buttonOvertone,
                                maxHeight: 28)
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
