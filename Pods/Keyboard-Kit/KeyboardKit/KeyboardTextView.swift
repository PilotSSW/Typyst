// Douglas Hill, December 2019

import UIKit

/// A text view that supports hardware keyboard commands to use the selection for find, find previous/next, and jump to the selection.
open class KeyboardTextView: UITextView, ResponderChainInjection {

    private lazy var findKeyCommands: [UIKeyCommand] = [
        UIKeyCommand((.command, "g"), action: #selector(kbd_findNext), title: localisedString(.find_next)),
        UIKeyCommand(([.command, .shift], "g"), action: #selector(kbd_findPrevious), title: localisedString(.find_previous)),
        UIKeyCommand((.command, "e"), action: #selector(kbd_useSelectionForFind), title: localisedString(.find_useSelection)),
        UIKeyCommand((.command, "j"), action: #selector(kbd_jumpToSelection), title: localisedString(.find_jump)),
    ]

    private lazy var scrollViewKeyHandler = ScrollViewKeyHandler(scrollView: self, owner: self)

    public override var keyCommands: [UIKeyCommand]? {
        var commands = super.keyCommands ?? []

        if isSelectable {
            commands += findKeyCommands
        }

        return commands
    }

    public override var next: UIResponder? {
        scrollViewKeyHandler
    }

    func nextResponderForResponder(_ responder: UIResponder) -> UIResponder? {
        super.next
    }
}

extension UITextView {
    override var kbd_isArrowKeyScrollingEnabled: Bool {
        isEditable == false
    }

    override var kbd_isSpaceBarScrollingEnabled: Bool {
        isEditable == false
    }
}

private extension UITextView {

    /// Selects the next instance of the text that was previously searched for, starting from the current selection
    /// or insertion point. Wraps to search from the start if needed. Scrolls to make the selection visible.
    @objc func kbd_findNext(_ sender: UIKeyCommand) {
        findNext(isBackwards: false)
    }

    /// Selects the previous instance of the text that was previously searched for, starting from the current
    /// selection or insertion point. Wraps to search from the end if needed. Scrolls to make the selection visible.
    @objc func kbd_findPrevious(_ sender: UIKeyCommand) {
        findNext(isBackwards: true)
    }

    /// Selects the next (or previous if isBackwards is true) instance of the text that was previously searched for,
    /// starting from the current selection or insertion point. Wraps around if needed. Scrolls to make the selection visible.
    private func findNext(isBackwards: Bool) {
        // Possible improved implementation: use a substring and localizedStandardRange.

        guard let textToFind = findPasteboard.string, let selectedTextRange = selectedTextRange else {
            return
        }

        let searchStartOffset = isBackwards ? 0 : offset(from: beginningOfDocument, to: selectedTextRange.end)
        let searchLength = isBackwards ? offset(from: beginningOfDocument, to: selectedTextRange.start) : offset(from: selectedTextRange.end, to: endOfDocument)

        let rangeToSearch = Range(NSRange(location: searchStartOffset, length: searchLength), in: text)

        var options: NSString.CompareOptions = [.caseInsensitive, .diacriticInsensitive]
        if isBackwards { options.insert(.backwards) }

        // Try rangeToSearch first and then wrap around to the start/end if the text isn’t found in that range.
        guard let targetRange = text.range(of: textToFind, options: options, range: rangeToSearch) ?? text.range(of: textToFind, options: options) else {
            return
        }

        selectedRange = NSRange(targetRange, in: text)
        jumpToSelection()
    }

    /// If there is selected text, it is marked as being used for find/search.
    @objc func kbd_useSelectionForFind(_ sender: UIKeyCommand) {
        guard let selectedTextRange = selectedTextRange, let selectedText = text(in: selectedTextRange), selectedText.isEmpty == false else {
            return
        }

        findPasteboard.string = selectedText
    }

    /// Scrolls so the current selected text or the insertion point is visible.
    @objc func kbd_jumpToSelection(_ sender: UIKeyCommand) {
        jumpToSelection()
    }

    /// Scrolls so the current selected text or the insertion point is visible.
    /// Does not scroll with animation to keep the interaction fast and match AppKit.
    private func jumpToSelection() {
        // scrollRangeToVisible(selectedRange) does not consider insets so use different API.
        
        guard let selectedTextRange = selectedTextRange else {
            return
        }

        // Add a bit of padding on the top and bottom so the text doesn’t appear right at the top/bottom edge.
        let targetRectangle = firstRect(for: selectedTextRange).inset(by: UIEdgeInsets(top: -8, left: 0, bottom: -10, right: 0))
        scrollRectToVisible(targetRectangle, animated: false)
    }
}

/// A pasteboard that stores the most recently searched for text.
/// It’s a shame this can’t be shared across apps because that’s a very useful timesaver on the Mac.
private let findPasteboard = UIPasteboard.withUniqueName()
