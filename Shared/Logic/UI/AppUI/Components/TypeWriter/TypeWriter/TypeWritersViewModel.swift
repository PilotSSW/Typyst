//
//  TypeWritersViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 10/19/21.
//

import Combine
import Foundation

class TypeWriterViewModel: ObservableObject {
    internal let id = UUID()

    private let keyboardServiceTag = "VirtualKeyboardAnimator"
    private var store = Set<AnyCancellable>()
    
    private var documentsService: DocumentsService
    private var keyboardService: KeyboardService
    private var typeWriterService: TypeWriterService
    private(set) var keyboardContainerViewModel: KeyboardContainerViewModel
    
    @Published var currentDocument: Document?
    @Published var currentDocumentViewModel: DocumentViewModel?
    
    @Published var showPaper: Bool = false
    @Published var showKeyboard: Bool = true
    
    init(documentsService: DocumentsService = AppDependencyContainer.get().documentsService,
         keyboardService: KeyboardService = RootDependencyContainer.get().keyboardService,
         typeWriterService: TypeWriterService = RootDependencyContainer.get().typeWriterService)
    {
        self.documentsService = documentsService
        self.keyboardService = keyboardService
        self.typeWriterService = typeWriterService
        
        keyboardContainerViewModel = KeyboardContainerViewModel(typeWriterService: typeWriterService,
                                                                keyboardRequiresNextKeyboardButton: false,
                                                                keyboardModelActionsDelegate: nil,
                                                                shouldShowSettingsButton: false)
        
        registerObservers()
    }
    
    deinit {
        print("TypeWriter view model deallocated")
    }
}

/// MARK: Private class functions
extension TypeWriterViewModel {
    private func registerObservers() {
        typeWriterService.$loadedTypewriter.sink { [weak self] _ in
            guard let self = self else { return }
            self.reloadKeyboardServiceObserver()
        }
        .store(in: &store)
        
        documentsService.$currentDocument.sink { [weak self] currentDocument in
            guard let self = self else { return }
            self.onDocumentServiceLoadNewDocument(currentDocument)
        }
        .store(in: &store)
    }
    
    private func reloadKeyboardServiceObserver() {
        keyboardService.registerKeyPressCallback(withTag: keyboardServiceTag,
                                                 shouldOverwriteExistingTag: true) { [weak self] keyEvent in
            guard let self = self else { return }
            let keyViewModels = self.keyboardContainerViewModel.keyboardViewModel.keyViewModels.filter({ $0.key == keyEvent.key })
            keyViewModels.forEach({ $0.onTap(direction: keyEvent.direction, sendKeypressToDelegate: false)})
        }
    }
    
    private func onDocumentServiceLoadNewDocument(_ setDocument: Document?) {
        if let document = setDocument {
            currentDocument = document
            currentDocumentViewModel = DocumentViewModel(document)
            showPaper = true
        }
        else {
            currentDocumentViewModel = nil
            showPaper = false
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
