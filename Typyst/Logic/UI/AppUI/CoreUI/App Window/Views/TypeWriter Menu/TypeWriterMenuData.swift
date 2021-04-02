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
        onClick: ({  App.instance.ui.appMenu?.loadOlympiaSM3(nil) }))

    static var modelP = TypeWriterMenuOption(.Royal_Model_P,
        onClick: ({  App.instance.ui.appMenu?.loadRoyalModelP(nil) }))

    static var silent = TypeWriterMenuOption(.Smith_Corona_Silent,
        onClick: ({  App.instance.ui.appMenu?.loadSmithCoronaSilent(nil)}))

    static var typeWriters: [TypeWriterMenuOption]{
        [ sm3, modelP, silent ]
    }
}
