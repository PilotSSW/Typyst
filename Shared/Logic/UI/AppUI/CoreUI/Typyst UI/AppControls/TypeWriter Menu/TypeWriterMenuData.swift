//
//  TypeWriterMenuData.swift
//  Typyst
//
//  Created by Sean Wolford on 2/23/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import Foundation

class TypeWriterMenuOption {
    let modelType: TypeWriterModel.ModelType
    let model: TypeWriterModel
    let onClick: () -> Void

    init(_ modelType: TypeWriterModel.ModelType, onClick: @escaping () -> Void = {}) {
        self.modelType = modelType
        self.model = TypeWriterModel(modelType)
        self.onClick = onClick
    }
}

class TypeWriterMenuOptions {
    static var sm3 = TypeWriterMenuOption(.Olympia_SM3,
        onClick: ({
          AppCore.instance.typeWriterHandler.setCurrentTypeWriter(modelType: .Olympia_SM3)
        }))

    static var modelP = TypeWriterMenuOption(.Royal_Model_P,
        onClick: ({
            AppCore.instance.typeWriterHandler.setCurrentTypeWriter(modelType: .Royal_Model_P)
        }))

    static var silent = TypeWriterMenuOption(.Smith_Corona_Silent,
        onClick: ({
            AppCore.instance.typeWriterHandler.setCurrentTypeWriter(modelType: .Smith_Corona_Silent)
        }))

    static var typeWriters: [TypeWriterMenuOption]{
        [ sm3, modelP, silent ]
    }
}
