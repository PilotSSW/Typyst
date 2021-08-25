//
//  KeyboardContainerViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 8/15/21.
//

import Combine
import Foundation
import struct SwiftUI.CGFloat

final class KeyboardContainerViewModel: ObservableObject, Loggable {
    private var subscriptions = Set<AnyCancellable>()
    enum VisibleComponent {
        case keyboard
        case settings
    }
    @Published private(set) var visibleComponent: VisibleComponent = .keyboard
    @Published private(set) var keyboardViewModel: KeyboardViewModel = KeyboardViewModelFactory.createKeyboardViewModel(forTypeWriterModel: .Unknown)

    private var typeWriterService: TypeWriterService

    init(typeWriterService: TypeWriterService = RootDependencyContainer.get().typeWriterService,
         keyboardRequiresNextKeyboardButton: Bool = true,
         keyboardModelActionsDelegate: KeyboardModelActionsDelegate? = nil) {

        self.typeWriterService = typeWriterService

        typeWriterService.$loadedTypewriter
            .sink { [weak self] typeWriter in
                if let typeWriter = typeWriter {
                    guard let self = self else { return }
                    self.reloadKeyboard(modelType: typeWriter.modelType,
                                        requiresNextKeyboardButton: keyboardRequiresNextKeyboardButton,
                                        keyboardModelActionsDelegate: keyboardModelActionsDelegate)
                }
            }
            .store(in: &subscriptions)
    }

    var currentTypeWriterModel: TypeWriterModel.ModelType {
        typeWriterService.loadedTypewriter?.modelType ?? keyboardViewModel.modelType
    }

    var cornerRadius: CGFloat {
        keyboardViewModel.cornerRadius
    }

    var keyboardModel: KeyboardModel {
        keyboardViewModel.model
    }

    func showComponent(_ component: VisibleComponent) {
        self.visibleComponent = component
        logEvent(.trace, "Show keyboard component: \(component)")
    }

    func reloadKeyboard(modelType: TypeWriterModel.ModelType,
                        requiresNextKeyboardButton: Bool = true,
                        keyboardModelActionsDelegate: KeyboardModelActionsDelegate? = nil) {
        keyboardViewModel = KeyboardViewModelFactory.createKeyboardViewModel(forTypeWriterModel: modelType,
                                                                             requiresNextKeyboardButton: requiresNextKeyboardButton)

        if let keyboardModelActionsDelegate = keyboardModelActionsDelegate {
            keyboardViewModel.model.keyActionsDelegate = keyboardModelActionsDelegate

            keyboardModel.setRequestToShowSettings { [weak self] in
                guard let self = self else { return }
                self.visibleComponent = .settings
            }
        }
    }
}
