//: A Cocoa based Playground to present user interface

import AppKit
import PlaygroundSupport

//let nibFile = NSNib.Name("MyView")
//var topLevelObjects : NSArray?
//
//Bundle.main.loadNibNamed(nibFile, owner:nil, topLevelObjects: &topLevelObjects)
//let views = (topLevelObjects as! Array<Any>).filter { $0 is NSView }

import Combine
import SwiftUI

protocol TextLayout: NSObject, NSTextStorageDelegate, NSLayoutManagerDelegate, NSTextViewDelegate {//}, Loggable {
    var storage: NSTextStorage {get set}
    var layoutManager: NSLayoutManager {get set}
    var textContainers: [NSTextContainer] {get set}
    var textViews: [NSTextView] {get set}
}

extension TextLayout {
    var defaultFont: NSFont {
        NSFont(name: "AmericanTypewriter",
               size: 14)//)TextSize.large.cgFloatSize)
        ?? .systemFont(ofSize: 14)//TextSize.normal.cgFloatSize)
    }
    
    init(with sentences: [String]) {
        self.init()
        initializeStorageWithText(sentences)
        initializeLayoutManagers()
        
    }
    
        /// MARK: Storage Functions
    public func initializeStorageWithText(_ sentences: [String]) {
        storage.delegate = self
        
        sentences.forEach({
            let attributedString = NSAttributedString(string: $0)
            storage.append(attributedString)
        })
        
        storage.font = defaultFont
    }
    
        ///MARK: LayoutManager Functions
    public func initializeLayoutManagers() {
        layoutManager.delegate = self
        storage.addLayoutManager(layoutManager)
    }
    
        /// MARK: TextContainer Functions
    public func createAndAddNewTextContainer(withSize size: NSSize = NSSize(width: 300, height: 300)) -> NSTextContainer {
        let textContainer = NSTextContainer(containerSize: size)
        textContainer.widthTracksTextView = true
        textContainer.heightTracksTextView = true
        layoutManager.addTextContainer(textContainer)
        textContainers.append(textContainer)
        return textContainer
    }
    
    public func removeTextContainer(_ textContainer: NSTextContainer) -> Bool {
        if let index = layoutManager.textContainers.firstIndex(of: textContainer) {
            layoutManager.removeTextContainer(at: index)
            textContainers.remove(at: index)
            return true
        }
        else {
//            logEvent(.info, "TextContainer not found in layout manager")
            return false
        }
    }
    
        /// MARK: TextView Functions
    public func createAndAddNewTextView(withFrame frame: NSRect = NSRect(origin: .zero, size: NSSize(width: 300, height: 300))) -> NSTextView {
        let textContainer = createAndAddNewTextContainer(withSize: frame.size)
        let textView = NSTextView(frame: frame, textContainer: textContainer)
        
        textView.delegate = self
        textView.font = defaultFont
        textViews.append(textView)
        
        return textView
    }
    
    public func removeTextView(_ textView: NSTextView) -> Bool {
        if let index = textViews.firstIndex(of: textView) {
            textViews.remove(at: index)
            
            if let container = textView.textContainer {
                return removeTextContainer(container)
            }
            else {
                return true
            }
        }
        else {
//            logEvent(.info, "TextViews not removed")
            return false
        }
    }
}

class MultiPageTextLayout: NSObject, TextLayout {//}, Loggable {
    
    var storage: NSTextStorage = NSTextStorage()
    var layoutManager: NSLayoutManager = NSLayoutManager()
    var textContainers: [NSTextContainer] = []
    var textViews: [NSTextView] = []
    
    var timer: Timer = Timer()
    
    @Published var currentCursorPosition: CGRect? = nil
        //    var onEditingChanged       : [() -> Void] = []
        //    var onCommit               : [() -> Void] = []
        //    var onTextChange           : [(String) -> Void] = []
    
    deinit {
        print("Deallocating MultiPageTextLayout")
    }
}

extension MultiPageTextLayout: NSTextStorageDelegate {
    
}

extension MultiPageTextLayout: NSLayoutManagerDelegate {
    
}

extension MultiPageTextLayout: NSTextViewDelegate {
    func textDidBeginEditing(_ notification: Notification) {
            //onEditingChanged()
        print("did begin editting")
    }
    
    func textDidChange(_ notification: Notification) {
        print("text did change")
        if let textView = notification.object as? NSTextView {
//            if let cursorFrame = textView.getCursorPositionInFrame() {
//                currentCursorPosition = cursorFrame
//            }
        }
    }
    
    func textDidEndEditing(_ notification: Notification) {
        print("text did end editting")
            //onCommit()
    }
}

struct TextEditorView: NSViewRepresentable {
    typealias NSViewType = NSTextView
        //}: Loggable {
    internal let id = UUID()
    
//    var textContainer: NSTextContainer
//    var textView: NSTextView
    var layout: TextLayout
    
    init(withTextLayout layout: TextLayout,
         andFrameSize frame: CGRect = .zero) {
        self.layout = layout
        let textView = layout.createAndAddNewTextView(withFrame: frame)
//        self.textView = textView
//        self.textContainer = textView.textContainer ?? NSTextContainer()
        
        commonInit(textView: textView)
    }
    
    private func commonInit(textView: NSTextView) {
            // display properties
        textView.isRulerVisible = true
        textView.drawsBackground = true
        textView.backgroundColor = .gray
        textView.textColor = .black//NSColor(cgColor: AppColor.textBody.cgColor ?? .black)
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        textView.autoresizingMask = [.height, .width]
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false
        textView.maxSize                 = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        textView.minSize                 = NSSize(width: 100, height: 100)
        
        textView.isEditable = true
        textView.isSelectable = false
        textView.isHidden = false
        textView.isFieldEditor = true
        textView.isRichText = false
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeNSView(context: Context) -> NSTextView {
        let textView = context.coordinator.textView
        if textView.textContainer == nil {
            print("Make NSView missing textContainer")
        }
        
        print("Text View created: \(id)")
        
        return textView
    }
    
    func updateNSView(_ view: NSTextView, context: Context) {
        let textView = context.coordinator.textView
        print("Text View updated: \(id)")
        
        textView.backgroundColor = .blue
        
        if textView.textContainer == nil {
            print("Update NSView missing textContainer: \(id)")
            textView.backgroundColor = .red
        }
        else {
            textView.backgroundColor = .green
        }
        
        print(textView.visibleRect)
    }
    
        // MARK: - Coordinator
    class Coordinator: NSObject {
        var parent: TextEditorView
        var textView: NSTextView
        
        init(_ parent: TextEditorView) {
            self.parent = parent
            self.textView = parent.layout.textViews.first ?? NSTextView()
            print(textView)
        }
    }
}


// Present the view in Playground
let layout = MultiPageTextLayout(with: [
    "First sentence",
    "Second sentence",
    "Third sentence"
])
let rootView = TextEditorView(withTextLayout: layout,
                                andFrameSize: CGRect(origin: .zero,
                                                     size: CGSize(width: 500, height: 500)))

let textView = rootView.layout.textViews.first

let editorView = NSHostingController(rootView: rootView.frame(width: 500, height: 500))
print(editorView.view.frame)

let textView2 = rootView.layout.textViews.first

PlaygroundPage.current.liveView = editorView.view //views[0] as! NSView
print(layout.storage)

let textView3 = rootView.layout.textViews.first

