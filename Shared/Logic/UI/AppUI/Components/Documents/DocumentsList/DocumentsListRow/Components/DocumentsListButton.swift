//
//  DocumentsListButton.swift
//  Typyst
//
//  Created by Sean Wolford on 10/11/21.
//

import SwiftUI

struct DocumentsListButton<Content: View>: View {
    private let id = UUID()

    var content: Content
    var onSelect: () -> Void
    var onReturn: (() -> Void)? = nil
    var showNeumorphicButton: Bool = true
    
    init(onSelect: @escaping () -> Void,
         onReturn: (() -> Void)? = nil,
         showNeumorphicButton: Bool = true,
         _ content: () -> Content) {
        self.onSelect = onSelect
        self.onReturn = onReturn
        self.showNeumorphicButton = showNeumorphicButton
        self.content = content()
    }

    var body: some View {
        if OSHelper.runtimeEnvironment == .iOS {
            let link = NavigationLink(
                destination: TypeWriterView()
                    .onAppear(perform: onSelect)
                    .onDisappear(perform: onReturn),
                label: {
                    content
                })
                
            if showNeumorphicButton {
                link.buttonStyle(NeumorphicButtonStyle(backgroundColor: AppColor.buttonNeutral))
            }
            else {
                link.buttonStyle(PlainButtonStyle())
            }
        }
        else {
            let button = Button(action: onSelect) {
                content
            }
            
            if showNeumorphicButton {
                button.buttonStyle(NeumorphicButtonStyle(backgroundColor: AppColor.buttonNeutral))
            }
            else {
                button.buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct DocumentListButton_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsListButton(onSelect: {}) {
            Text("Hello!")
        }
    }
}
