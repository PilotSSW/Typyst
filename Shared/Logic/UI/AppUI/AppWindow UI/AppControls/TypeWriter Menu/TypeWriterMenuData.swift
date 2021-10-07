//
//  TypeWriterMenuData.swift
//  Typyst
//
//  Created by Sean Wolford on 2/23/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

final class TypeWriterMenuOption {
    let modelType: TypeWriterModel.ModelType
    let model: TypeWriterModel
    let onClick: () -> Void

    init(_ modelType: TypeWriterModel.ModelType, onClick: @escaping () -> Void = {}) {
        self.modelType = modelType
        self.model = TypeWriterModel(modelType)
        self.onClick = onClick
    }
}

final class TypeWriterMenuOptions {
    private var typeWriterService: TypeWriterService

    init(withTypeWriterService typeWriterService: TypeWriterService = RootDependencyContainer.get().typeWriterService) {
        self.typeWriterService = typeWriterService
    }

    var typeWriters: [TypeWriterMenuOption] {
        let sm3 = TypeWriterMenuOption(.Olympia_SM3,
                                       onClick: ({ [weak self] in
                                           guard let self = self else { return }
                                           self.typeWriterService.setCurrentTypeWriter(modelType: .Olympia_SM3)
                                       }))

        let modelP = TypeWriterMenuOption(.Royal_Model_P,
                                          onClick: ({ [weak self] in
                                              guard let self = self else { return }
                                              self.typeWriterService.setCurrentTypeWriter(modelType: .Royal_Model_P)
                                          }))

        let silent = TypeWriterMenuOption(.Smith_Corona_Silent,
                                          onClick: ({ [weak self] in
                                              guard let self = self else { return }
                                              self.typeWriterService.setCurrentTypeWriter(modelType: .Smith_Corona_Silent)
                                          }))

        return [ sm3, modelP, silent ]
    }
}
