//
// Created by Sean Wolford on 2/14/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation

class TypeWriterState: ObservableObject {
    @Published private(set) var cursorIndex = 0
    @Published private(set) var marginWidth = 80

    @Published private(set) var lineIndex = 0
    @Published private(set) var linesPerPage = 25

    private(set) var capsOn = false

    init(marginWidth: Int = 80) {
        DispatchQueue.main.async {
            self.marginWidth = marginWidth
        }
    }

    var isLineIndexIsOnLastLine: Bool {
        lineIndex == linesPerPage
    }

    func incrementCursor(numberOfPositions: Int = 1) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.cursorIndex >= 0 {
                self.cursorIndex += numberOfPositions
            }
        }
    }

    func newLine(numberOfNewLines: Int = 1) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.lineIndex >= 0 {
                self.lineIndex += numberOfNewLines
            }
        }
    }

    func resetCursorIndex() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.cursorIndex = 0
        }
    }
    
    func resetLineIndex() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.lineIndex = 0
        }
    }

    func setCaps() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.capsOn = !self.capsOn
        }
    }
}
