//
//  DocumentViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 9/16/21.
//

import Combine
import Foundation

class DocumentViewModel: NSObject, Identifiable, ObservableObject, Loggable {
    internal let id = UUID()

    var documentsService: DocumentsService = AppDependencyContainer.get().documentsService
    var document: Document
    var documentTextLayout: MultiPageTextLayout
    
    @Published private var pageViewModels: [PageViewModel] = []
    @Published private(set) var nonEditablePageViewModels: [PageViewModel] = []
    @Published private(set) var currentPageEditorViewModel: CurrentPageEditorViewModel? = nil
    
    /// MARK: Object lifecycle methods

    init(_ document: Document) {
        self.document = document
        
        let sentences = document.textBody.components(separatedBy: ".!?")
        self.documentTextLayout = MultiPageTextLayout(with: sentences)

        super.init()
        
        let _ = documentTextLayout.addDelegate(self)
        
        currentPageEditorViewModel = CurrentPageEditorViewModel(layout: documentTextLayout)
        requestToAddNextTextContainerAndView()
        
        logEvent(.debug, "Document view model created: \(id)")
    }
    
    deinit {
        let _ = documentTextLayout.removeDelegate(self)
        logEvent(.debug, "Document view model deallocated: \(id)")
    }

    func onDisappear() {
        let _ = documentsService.updateDocument(document)
    }
    
    func setNewEditorPage(_ pageViewModel: PageViewModel) {
        nonEditablePageViewModels = pageViewModels.filter({
            $0.pageIndex != pageViewModel.pageIndex
        })
        nonEditablePageViewModels.forEach({ $0.pageLayoutViewModel.isEditable = false })

        pageViewModel.pageLayoutViewModel.isEditable = true
        currentPageEditorViewModel?.setPageViewModel(pageViewModel)
    }
}

/// MARK: Private logic functions
extension DocumentViewModel {
    private func addPageViewModel() -> PageViewModel {
        let pageIndex = pageViewModels.count
        let pageViewModel = PageViewModel(
            pageIndex: pageIndex,
            withTextLayout: documentTextLayout,
            withTitle: pageIndex == 0 ? document.documentName : "")
        
        pageViewModels.append(pageViewModel)
        
        return pageViewModel
    }
}

extension DocumentViewModel: MultiPageTextLayoutDelegate {
    func requestToAddNextTextContainerAndView() {
        let hasUninitializedTextViews = pageViewModels
            .map({ $0.pageLayoutViewModel.textView })
            .filter({ $0 == nil })
            .count > 0
        
        if !hasUninitializedTextViews {
            let pageViewModel = addPageViewModel()
            setNewEditorPage(pageViewModel)
        }
    }
}
