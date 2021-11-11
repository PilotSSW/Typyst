//
// Created by Sean Wolford on 11/2/21.
//

import Foundation

class TextLayoutService {
    func createMultiPageLayoutForDocument(_ document: Document) -> MultiPageTextLayout {
        let sentences = [
            "This is a sentence!!",
            "This is another sentence!",
            "This is a huge fucking paragraph of text that should be split into several sentences for better grammar and punctuation, because runon sentences are hard to read and understand and often lead to points that lack clarity and flow to the readers who really want to enjoy the body of text."
        ]//document.textBody.components(separatedBy: ".?")
        return MultiPageTextLayout(with: sentences)
    }
}

