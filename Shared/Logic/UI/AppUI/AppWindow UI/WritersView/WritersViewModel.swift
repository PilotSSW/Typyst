//
//  WritersView.swift
//
//  Created by Sean Wolford on 9/9/21.
//

import Combine
import Foundation
import struct SwiftUI.CGFloat

class WritersViewModel: ObservableObject {
    private var store = Set<AnyCancellable>()
    private(set) var documentsService: DocumentsService

    @Published var currentDocument: Document? = nil
    @Published var currentDocumentViewModel: DocumentViewModel? = nil
    
    @Published var shouldShowWebView: Bool = false

    init(documentsService: DocumentsService = AppDependencyContainer.get().documentsService) {
        self.documentsService = documentsService
        registerWebViewLoaderObserver()
    }

    private func registerWebViewLoaderObserver() {
        documentsService.$webDocumentIsLoaded
            .sink { [weak self] webDocumentIsLoaded in
                guard let self = self else { return }
                self.shouldShowWebView = webDocumentIsLoaded
            }
            .store(in: &store)
        
        documentsService.$currentDocument
            .sink { [weak self] currentDocument in
                guard let self = self else { return }
                self.currentDocumentViewModel = nil

                if let document = currentDocument {
                    self.currentDocumentViewModel = DocumentViewModel(document)
                }
            }
            .store(in: &store)
    }
}


