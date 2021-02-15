//
// Created by Sean Wolford on 2/14/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation

class TypeWriterState {
    private(set) var cursorIndex = 0
    private(set) var marginWidth = 80

    private(set) var lineIndex = 0
    private(set) var linesPerPage = 25

    private(set) var shiftIsPressed = false
    private(set) var capsOn         = false

    init(marginWidth: Int = 80) {
        self.marginWidth = marginWidth
    }

    var isLineIndexIsOnLastLine: Bool {
        lineIndex == linesPerPage
    }

    func incrementCursor(numberOfPositions: Int = 1) {
        if cursorIndex >= 0 {
            lineIndex += numberOfPositions
        }
    }

    func newLine(numberOfNewLines: Int = 1) {
        if lineIndex >= 0 {
            lineIndex += numberOfNewLines
        }
    }

    func resetCursorIndex() {
        cursorIndex = 0
    }
    
    func resetLineIndex() {
        lineIndex = 0
    }

    func setCaps() {
        capsOn = !capsOn
    }

    func setShift() {
        shiftIsPressed = !shiftIsPressed
    }
}