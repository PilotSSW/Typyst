//
//  TypeWritersViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 10/19/21.
//

import Combine
import struct CoreGraphics.CGFloat
import Foundation

class TypeWriterViewModel: ObservableObject, Loggable {
    internal let id = UUID()

    private let keyboardServiceTag = "VirtualKeyboardAnimator"
    private var store = Set<AnyCancellable>()
    
    private var keyboardService: KeyboardService
    private var settingsService: SettingsService
    private var typeWriterService: TypeWriterService
    private(set) var keyboardContainerViewModel: KeyboardContainerViewModel
        
    @Published var showKeyboard: Bool = false
    
    private var hasAppeared: Bool = false
    
    init(keyboardService: KeyboardService = RootDependencyContainer.get().keyboardService,
         settingsService: SettingsService = RootDependencyContainer.get().settingsService,
         typeWriterService: TypeWriterService = RootDependencyContainer.get().typeWriterService)
    {
        self.keyboardService = keyboardService
        self.settingsService = settingsService
        self.typeWriterService = typeWriterService
        
        keyboardContainerViewModel = KeyboardContainerViewModel(typeWriterService: typeWriterService,
                                                                keyboardRequiresNextKeyboardButton: false,
                                                                keyboardModelActionsDelegate: nil,
                                                                shouldShowSettingsButton: false)
        
        registerObservers()
        
        logEvent(.debug, "TypeWriter view model created")
    }
    
    deinit {
        logEvent(.debug, "TypeWriter view model deallocated")
    }
    
    func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: { [weak self] in
            guard let self = self else { return }
            self.hasAppeared = true
            self.showKeyboard = self.settingsService.showTypeWriterView
        })
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
        
        settingsService.$showTypeWriterView.sink { [weak self] showTypeWriter in
            guard let self = self else { return }
            self.showKeyboard = showTypeWriter && self.hasAppeared
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
}

/// MARK: View Properties
extension TypeWriterViewModel {
    var keyboardMinWidth: CGFloat { OSHelper.runtimeEnvironment == .iOS ? 180 : 400 }
    var keyboardMaxWidth: CGFloat { 900 }
    var keyboardMinHeight: CGFloat { OSHelper.runtimeEnvironment == .iOS ? 180 : 265 }
    var keyboardMaxHeight: CGFloat { OSHelper.runtimeEnvironment == .iOS ? 200 : .infinity }
}
