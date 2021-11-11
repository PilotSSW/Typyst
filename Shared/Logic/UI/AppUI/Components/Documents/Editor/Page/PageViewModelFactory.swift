//
//  PageViewModelFactory.swift
//  Typyst
//
//  Created by Sean Wolford on 11/10/21.
//

import Foundation

class PageViewModelFactory {
    static func generateRandomPageViewModelsForText(number: Int = 5,
                                                    withLayout layout: TextLayout = MultiPageTextLayout(),
                                                    layoutFrameSize: CGRect = CGRect(origin: .zero, size: CGSize(width: 250, height: 650))) -> [PageViewModel] {
        if layout.storage.string.isEmpty {
            testingText
                .components(separatedBy: ".\n")
                .map({ NSAttributedString(string: $0) })
                .forEach({ layout.storage.append($0) })
        }
        
        var viewModels = [PageViewModel]()
        
        for currentIndex in 1...number {
            let newVM = PageViewModel(pageIndex: currentIndex, withTextLayout: layout)
            viewModels.append(newVM)
        }
        
        return viewModels
    }

    static var testingText: String = """
        HomeProgrammingCocoa

    5.2 Assembling the Text System

    For many applications that work with text, using NSTextView as the frontend interface to the text provides a great deal of functionality. This is by far the easiest way of working with the text system: you only need to drop a text view into your interface using Interface Builder, and you're ready to go.

    Using NSTextView's APIs as the sole means of working with the text system does not offer the flexibility that can be achieved by assembling the individual components manually. By starting with an NSTextStorage object and adding layout managers, text containers, and text views, document layouts can have multiple columns and pages, have irregular areas of text, or present the same text in two different layouts.

    Before exploring the manually assembly of text components, consider these rules that tell you what you can and cannot do:

        A text storage object may have one or more layout manager objects that it manages.

        Each layout manager instance may manage one or more instances of NSTextContainer.

        Each text container has exactly one text view associated with it.

    By varying the structure of the network with respect to the first two rules, you can create the possibilities mentioned earlier.

    Several methods in NSTextStorage, NSLayoutManager, and NSTextContainer facilitate assembly and management of the object network.

    NSTextStorage

        This class offers the following methods for managing its layout managers:

        addLayoutManager:

            Adds the specified layout manager to the list of layout managers owned by the text storage object
        removeLayoutManager:

            Removes the specified layout manager from the collection of layout managers owned by the text storage object
        layoutManagers

            Returns an NSArray of layout managers currently managed by the text storage object

    NSLayoutManager

        This class defines the following four methods for managing its collection of NSTextContainers:

        addTextContainer:

            Adds the specified text container to the end of the list of text containers managed by the layout manager
        insertTextContainer:atIndex:

            Inserts a text container at the indicated array index into the layout manager's text container array
        removeTextContainerAtIndex:

            Removes the text container found at the specified index from the layout manager
        textContainers

            Returns an array of text containers managed by the layout manager

    The nature of these methods is differs from those declared by NSTextStorage for managing layout managers. The order of text containers in a layout manager defines the order in which text containers will be filled with text: containers at lower indices will be filled before those at higher indices.

    Finally, NSTextContainer associates itself with its partner text view object by using setTextView:. Later, the text view is retrieved with the textView method.
    5.2.1 Layout Scenarios

    Having control over the layout managers and text containers allows a great deal of flexibility over how a body of text appears onscreen or in print. The possibilities increase when you introduce subclasses of NSTextContainer to the system for defining irregular, or nonrectangular layout regions.
    5.2.1.1 Simple layout

    The simplest layout consists of a single view that displays a continuous body of text. This is the layout favored by applications that deal with plain text, such as source code or HTML, as they have little interest in how the text might appear on the printed page. Figure 5-5 shows the object configuration that establishes this "normal" view.
    Figure 5-5. Configuration of the core classes for displaying a body of continuous text
    figs/cocn_0505.gif

    Figure 5-5 shows one instance of each of the four core text classes: one text storage object that manages a single layout manager, which in turn manages one text container/text view object pair. The text view exists as a subview of an NSScrollView, which allows the user to scroll through the contents of a larger document that cannot be displayed in one screen. You can build this simply by adding a text view to the application in Interface Builder or by using NSTextView's initWithFrame:.
    5.2.1.2 Paginating text

    A more complex text layout, shown in Figure 5-6, is the so-called "page-view," in which the text is displayed onscreen as a series of pages.
    Figure 5-6. A more complex configuration that presents text in a "page-view"
    figs/cocn_0506.gif

    This layout is common in word processors, such as Microsoft Word or TextEdit, where text layout on multiple pages is important. This layout is implemented with a pair of NSTextContainer and NSTextView objects for each page of the document. The layout manager determines the order in which to fill each page according to the order of NSTextContainers in the layout manager's array of text containers. The mechanism NSLayoutManager uses to notify a delegate that the current text container is filled can be a cue to create a new text container/text view pair and accommodate more text. From the user's perspective, this mechanism allows pages to be added to the document and displayed on screen dynamically.
    5.2.1.3 Multicolumn text

    The pattern introduced in Figure 5-6 can apply to the situation in Figure 5-7: a multicolumn, multipage document. In this configuration, a pair of NSTextContainer and NSTextView objects represents each column. The order in which columns and pages are filled depends on the order of NSTextContainer objects in the NSLayoutManager instance.
    Figure 5-7. Objects involved in creating a multicolumn, multipage document
    figs/cocn_0507.gif

    This gives the illusion of four pages of text, which you might see in a Print Preview window. To create the appearance of a true multicolumn, multipage document (as in Figure 5-7), the column text views are grouped within a regular NSView which represents a page. That page (NSView) may be the same color of the column (the NSTextViews), which means that you only see the text on a solid background. Again, the collection of views that represent a single page is arranged on a gray background view that is a child view of a scroll view.
    5.2.1.4 Multiple simultaneous layouts

    As mentioned earlier, NSTextStorage objects are not limited to just one layout manager; they can have many layout managers, if necessary. This scenario lets you lay out the same body of text in multiple styles specified by each layout manager. Figure 5-8 illustrates how multiple layout managers can present text in two layouts simultaneously.
    Figure 5-8. Using multiple layout managers to display text data in different layouts
    figs/cocn_0508.gif

    The flexibility achieved through cleverly arranging NSTextViews within NSViews can create many effects, resulting in endless possibilities, as shown in Figure 5-9.
    Figure 5-9. You can create complex networks of objects
    figs/cocn_0509.gif
    5.2.2 NSLayoutManager Delegation

    NSLayoutManager employs a delegate object that may respond to two methods:

        layoutManager:didCompleteLayoutForTextContainer:atEnd:

        layoutManagerDidInvalidateLayout:

    The first method notifies the delegate when the layout manager finishes formatting the text in the specified text container object. This method can be used to control the appearance of progress indicators in the user interface, or it can enable or disable buttons that control text layout. NSLayoutManager passes nil as the text container argument when it has no more room to lay out its text in the existing text container. This information can be used tohelp you create a new text container/text view pair, which is added to the NSLayoutManager's list of managed text containers.

    Example 5-1 demonstrates how to implement layoutManager:didCompleteLayoutForTextContainer:atEnd:. The code in Example 5-1 creates the layout situation shown in Figure 5-6. When a text container fills up with text, the delegate responds by using this method to create additional layout space.
    Example 5-1. Creating text containers dynamically

    - (void)layoutManager:(NSLayoutManager *)lm
            didCompleteLayoutForTextContainer:(NSTextContainer *)tc
            atEnd:(BOOL)flag
    {
      if ( !tc ) {
        NSSize tcSize = NSMakeSize( 300, 500 );
        NSTextContainer *cont = [[NSTextContainer alloc]
                                    initWithContainerSize: tcSize];
        [[[textStorage layoutManagers]
                                lastObject] addTextContainer: cont];

        NSTextView *tv = [[NSTextView alloc]
                          initWithFrame:[self frameForNewTextView];
                          textContainer:cont];
        [canvas addSubview:tv];
      }
    }

    The delegate method in Example 5-1 is invoked every time the current text container fills up. However, your implementation will work only when the text container passed to you in the argument list is nil, which indicates that the layout manager has filled its current text container. This method deals with a filled text container by creating a new one and adding it to the list of text containers managed by the layout manager. This is accomplished with the NSTextContainer initializer, initWithContainerSize:.

    The textStorage variable is an instance variable of the class in which this method is implemented. This instance variable is assigned to the text storage object for the application. To add the new text container, cont, to the list of text containers managed by the layout manager, obtain the layout manager with the layoutManagers method. Since this method returns an NSArray of layout managers, even if there is just one, a lastObject method is sent to get an instance of NSLayoutManager, which receives an addTextContainer: message with cont as the argument.

    To create a text view to pair with the text container, use the designate initializer of NSTextView. This initializer requires a frame for the text view, as well as the text container it needs to associate with the text view. Example 5-1 relies on another hypothetical method, frameForNewTextView, to return a frame rect that places the new text view below the previous one. The text view is then added as a subview of canvas. In this example, canvas is best represented by the gray region of Figure 5-7; individual text views are pages displayed in a series on this background view.



        
        Part I: Introducing Cocoa
        
        Chapter 1. Objective-C
        Chapter 2. Foundation
        Chapter 3. The Application Kit
        Chapter 4. Drawing and Imaging
        Chapter 5. Text Handling
        
        5.1 Text System Architecture
        5.2 Assembling the Text System
        Chapter 6. Networking
        Chapter 7. Interapplication Communication
        Chapter 8. Other Frameworks
        Part II: API Quick Reference
        Method Index
        Part III: Appendix
    Remember the name: eTutorials.org
    Advertise on eTutorials.org
    Copyright eTutorials.org 2008-2021. All rights reserved.

    """
}
