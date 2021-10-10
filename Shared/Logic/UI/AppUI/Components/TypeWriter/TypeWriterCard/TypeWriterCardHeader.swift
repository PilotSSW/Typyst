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
    var maxHeight: CGFloat = 34

    @State
    var showAlert = false

    @ObservedObject
    var settingsService: SettingsService = RootDependencyContainer.get().settingsService

    var isSelected: Bool {
        $settingsService.selectedTypewriter.wrappedValue == model.rawValue
    }

    var body: some View {
        HStack() {
            Text(maker)
                .bold()
            Text("-")
            Text(modelName)
                .bold()
        }
        .frame(maxWidth: .infinity)
        .asStyledCardHeader(withBackgroundColor: isSelected
                                ? AppColor.buttonPrimary
                                : AppColor.buttonOvertone,
                            maxHeight: maxHeight,
                            onClickAction: onClick)
    }
}

struct TypeWriterCardHeader_Previews: PreviewProvider {
    static var previews: some View {
        let optionInfo = TypeWriterMenuOption(.Royal_Model_P)
        
        VStack() {
            TypeWriterCardHeader(maker: optionInfo.model.maker,
                                 model: optionInfo.model.model,
                                 modelName: optionInfo.model.name)
            
            TypeWriterCardHeader(maker: optionInfo.model.maker,
                                 model: optionInfo.model.model,
                                 modelName: optionInfo.model.name,
                                 onClick: {})
        }
    }
}
