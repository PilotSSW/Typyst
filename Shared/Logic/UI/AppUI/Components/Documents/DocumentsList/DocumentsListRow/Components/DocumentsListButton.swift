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
    @Binding var isSelected: Bool
    
    init(onSelect: @escaping () -> Void,
         onReturn: (() -> Void)? = nil,
         showNeumorphicButton: Bool = true,
         isSelected: Binding<Bool> = .constant(false),
         _ content: () -> Content) {
        self.onSelect = onSelect
        self.onReturn = onReturn
        self.showNeumorphicButton = showNeumorphicButton
        self._isSelected = isSelected
        self.content = content()
    }

    var body: some View {
        if showNeumorphicButton {
            button.buttonStyle(NeumorphicButtonStyle(backgroundColor: AppColor.buttonNeutral))
        }
        else {
            button.buttonStyle(PlainButtonStyle())
        }
    }
    
    @ViewBuilder
    private var button: some View {
        if OSHelper.runtimeEnvironment == .iOS {
            NavigationLink(
                destination: WritersView()
                    .onAppear(perform: onSelect)
                    .onDisappear(perform: onReturn),
                label: {
                    content
                })
        }
        else {
            Button(action: isSelected
                   ? withAnimation { onReturn ?? {} }
                   : withAnimation { onSelect }) {
                content
            }
        }
    }
}

struct DocumentListButton_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsListButton(onSelect: {}) {
            Text("Hello!")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
