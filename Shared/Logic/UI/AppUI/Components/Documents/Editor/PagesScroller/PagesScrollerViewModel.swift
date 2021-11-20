//
//  PagesScrollerViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 11/17/21.
//

import Combine
import Foundation

class PagesScrollerViewModel: ObservableObject {
    @Published private(set) var pages: [PageViewModel] = []
    
    func setPages(_ newPages: [PageViewModel]) {
        pages.removeAll()
        newPages.forEach({ addPage($0) })
    }
    
    func addPage(_ page: PageViewModel) {
        if pages.contains(where: { $0.id == page.id }) { return }
        
        page.setIsEditorPage(false)
        pages.append(page)
    }
    
    func removePage(_ page: PageViewModel) {
        pages.removeAll(where: { $0.id == page.id })
    }
    
    func sortPages() {
        pages.sort(by: { $0.pageIndex < $1.pageIndex })
    }
}
