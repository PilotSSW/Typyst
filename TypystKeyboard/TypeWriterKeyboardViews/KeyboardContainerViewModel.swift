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
    @Published private(set) var keyboardViewModel: KeyboardViewModel

    private var typeWriterService: TypeWriterService

    init(typeWriterService: TypeWriterService = RootDependencyContainer.get().typeWriterService,
         keyboardRequiresNextKeyboardButton: Bool = true,
         keyboardModelActionDelegate: KeyboardModelActionsDelegate? = nil) {

        self.typeWriterService = typeWriterService

        let modelType = typeWriterService.loadedTypewriter?.modelType ?? .Royal_Model_P
        keyboardViewModel = KeyboardViewModelFactory.createKeyboardViewModel(forTypeWriterModel: modelType,
                                                                             requiresNextKeyboardButton: keyboardRequiresNextKeyboardButton)
        if let keyboardModelActionDelegate = keyboardModelActionDelegate {
            keyboardViewModel.model.keyActionsDelegate = keyboardModelActionDelegate

            keyboardModel.setRequestToShowSettings { [weak self] in
                guard let self = self else { return }
                self.visibleComponent = .settings
            }
        }
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
}
