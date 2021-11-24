//
//  DocumentViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 9/16/21.
//

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif
import Combine
import Foundation

class DocumentViewModel: NSObject, Identifiable, ObservableObject, Loggable {
    internal let id = UUID()

    var documentsService: DocumentsService = AppDependencyContainer.get().documentsService
    var document: Document
    lazy var documentTextLayout: MultiPageTextLayout = {
        let sentences = document.textBody.components(separatedBy: ".!?")
        return MultiPageTextLayout(with: sentences, delegate: self)
    }()
    
    @Published private var pageViewModels: [PageViewModel] = []
    @Published private(set) var pagesScrollerViewModel: PagesScrollerViewModel = PagesScrollerViewModel()
    @Published private(set) var currentPageEditorViewModel: CurrentPageEditorViewModel? = nil
    
    /// MARK: Object lifecycle methods

    init(_ document: Document) {
        self.document = document
        
        super.init()
                
        logEvent(.debug, "Document view model created: \(id)")
    }
    
    deinit {
        logEvent(.debug, "Document view model deallocated: \(id)")
    }
    
    func onAppear() {
        let container: NSTextContainer = documentTextLayout.textContainers.first
        ?? documentTextLayout.createAndAddNewTextContainer()
        
        newTextContainerAddedToLayout(container)
    }

    func onDisappear() {
        let _ = documentTextLayout.removeDelegate(self)
        let _ = documentsService.updateDocument(document)
    }

}

/// MARK: Private logic functions
extension DocumentViewModel {
    private func addPageViewModel() -> PageViewModel {
        let pageIndex = pageViewModels.count
        let pageViewModel = PageViewModel(
            pageIndex: pageIndex,
            withTextLayout: documentTextLayout,
            withDocument: document,
            withDocumentsService: documentsService)
        
        pageViewModels.append(pageViewModel)
        
        return pageViewModel
    }
    
    private func addPageViewModels(count: Int) -> [PageViewModel] {
        var pageVMs: [PageViewModel] = []
        
        for _ in 1...count {
            let pageViewModel = addPageViewModel()
            pageVMs.append(pageViewModel)
        }
        
        return pageVMs
    }
    
    
    private func setNewEditorPage(_ pageViewModel: PageViewModel? = nil) {
        if let pageViewModel = pageViewModel {
            pagesScrollerViewModel.removePage(pageViewModel)
            currentPageEditorViewModel = CurrentPageEditorViewModel(layout: documentTextLayout,
                                                                    currentPageViewModel: pageViewModel)
        }
        else {
            currentPageEditorViewModel = nil
        }
    }
    
    private func setScrollerPages(excludePages: [PageViewModel] = []) {
        for pageViewModel in pageViewModels {
            excludePages.contains { $0.id == pageViewModel.id }
                ? pagesScrollerViewModel.removePage(pageViewModel)
                : pagesScrollerViewModel.addPage(pageViewModel)
        }
        pagesScrollerViewModel.sortPages()
    }
}

extension DocumentViewModel: MultiPageTextLayoutDelegate {
    func newTextContainerAddedToLayout(_ textContainer: NSTextContainer) {
        let numberOfTextContainers = documentTextLayout.textContainers.count
        let numberOfPages = pageViewModels.count
        let numberToAdd = numberOfTextContainers - numberOfPages
        
        let newPageViewModels = addPageViewModels(count: numberToAdd)
        
        if let lastPage = newPageViewModels.last {
            setNewEditorPage(nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [weak self] in
                guard let self = self else { return }
                self.setScrollerPages(excludePages: [lastPage])
                self.setNewEditorPage(lastPage)
            })
        }
    }
    
    func textWasUpdated(_ text: String) {
        document.textBody = documentTextLayout.storage.string
        let _ = documentsService.updateDocument(document)
    }
}
