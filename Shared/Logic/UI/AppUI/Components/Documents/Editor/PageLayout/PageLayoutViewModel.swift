//
//  PageLayoutViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 11/10/21.
//

import AppKit
import Combine
import Foundation

class PageLayoutViewModel: ObservableObject, Identifiable, Loggable {
    internal let id = UUID()
    
    private var document: Document
    private var documentsService: DocumentsService
    private(set) var layout: TextLayout
    @Published var textView: NSTextView?
    
    var textAreaSize: CGSize {
        textView?.frame.size ?? .zero
    }
        
    // View model properties
    let pageIndex: Int
    @Published var title: String = "" {
        didSet {
            document.documentName = title.isEmpty
                ? "The Next Great Story in Typyst!"
                : title
            let _ = documentsService.updateDocument(document)
        }
    }
    
    @Published private(set) var isEditorPage: Bool = false {
        didSet {
            textView?.isEditable = isEditorPage
        }
    }
    
    init(withTextLayout layout: TextLayout, pageIndex: Int,
         withDocument document: Document,
         withDocumentsService docService: DocumentsService = AppDependencyContainer.get().documentsService
    ) {
        self.layout = layout
        self.pageIndex = pageIndex
        self.document = document
        self.documentsService = docService
        
        self.title = document.documentName
        
        logEvent(.trace, "PageLayout view model created: \(id)")
    }
    
    deinit {
        logEvent(.trace, "PageLayout view model deallocated: \(id)")
    }
    
    func onAppear() {

    }
    
    func onDisappear() {

    }
    
    func setIsEditorPage(_ bool: Bool) {
        isEditorPage = bool
    }
    
    private func createTextView() -> NSTextView {
        if let textView = layout.getTextViewAtIndex(pageIndex) {
            return textView
        }
        
        if let textContainer = layout.getTextContainer(atIndex: pageIndex) {
            let newTextView = layout.createAndAddNewTextView(withTextContainer: textContainer)
            textView = newTextView
            return newTextView
        }
        else {
            let newTextView = layout.createAndAddNewTextView()
            textView = newTextView
            return newTextView
        }
    }
    
    func setTextView() -> NSTextView {
        let tv = createTextView()
        self.textView = tv
        return tv
    }
}

extension PageLayoutViewModel: Equatable {
    static func == (lhs: PageLayoutViewModel, rhs: PageLayoutViewModel) -> Bool {
        lhs.id != rhs.id
    }
}

extension PageLayoutViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
