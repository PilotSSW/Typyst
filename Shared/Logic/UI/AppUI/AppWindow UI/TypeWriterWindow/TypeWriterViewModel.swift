//
// Created by Sean Wolford on 9/9/21.
//

import Combine
import Foundation
import struct SwiftUI.CGFloat

class TypeWriterViewModel: ObservableObject {
    private let keyboardServiceTag = "VirtualKeyboardAnimator"
    private var store = Set<AnyCancellable>()

    private(set) var documentsService: DocumentsService
    private(set) var keyboardService: KeyboardService
    private(set) var keyboardContainerViewModel: KeyboardContainerViewModel

    @Published var currentDocument: Document?
    @Published var currentDocumentViewModel: DocumentViewModel?
    @Published var shouldShowWebView: Bool = false

    init(documentsService: DocumentsService = AppDependencyContainer.get().documentsService,
         keyboardService: KeyboardService = RootDependencyContainer.get().keyboardService,
         typeWriterService: TypeWriterService = RootDependencyContainer.get().typeWriterService) {
        self.documentsService = documentsService
        self.keyboardService = keyboardService
        keyboardContainerViewModel = KeyboardContainerViewModel(typeWriterService: typeWriterService,
                                                                keyboardRequiresNextKeyboardButton: false,
                                                                keyboardModelActionsDelegate: nil,
                                                                shouldShowSettingsButton: false)
        registerWebViewLoaderObserver()
        typeWriterService.$loadedTypewriter.sink { [weak self] _ in
            guard let self = self else { return }
            keyboardService.removeListenerCallback(withTag: self.keyboardServiceTag)
            self.registerExternalKeyboardObserver()
        }
        .store(in: &store)

        documentsService.$currentDocument
            .sink { [weak self] currentDocument in
                guard let self = self else { return }
                self.currentDocument = currentDocument
                if let document = currentDocument {
                    self.currentDocumentViewModel = DocumentViewModel(document)
                }
                else {
                    self.currentDocumentViewModel = nil
                }
            }
            .store(in: &store)
    }

    private func registerWebViewLoaderObserver() {
        documentsService.$webDocumentIsLoaded.sink { [weak self] webDocumentIsLoaded in
            guard let self = self else { return }
            self.shouldShowWebView = webDocumentIsLoaded
        }
        .store(in: &store)
    }

    private func registerExternalKeyboardObserver() {
        keyboardService.registerKeyPressCallback(withTag: keyboardServiceTag) { [weak self] keyEvent in
            guard let self = self else { return }
            let keyViewModels = self.keyboardContainerViewModel.keyboardViewModel.keyViewModels.filter({ $0.key == keyEvent.key })
            keyViewModels.forEach({ $0.onTap(direction: keyEvent.direction, sendKeypressToDelegate: false)})
        }
    }
}

/// MARK: View Properties
extension TypeWriterViewModel {
    var keyboardMinWidth: CGFloat { OSHelper.runtimeEnvironment == .iOS ? 180 : 400 }
    var keyboardMaxWidth: CGFloat { 900 }
    var keyboardMinHeight: CGFloat { OSHelper.runtimeEnvironment == .iOS ? 180 : 265 }
    var keyboardMaxHeight: CGFloat { OSHelper.runtimeEnvironment == .iOS ? 200 : .infinity }
}
