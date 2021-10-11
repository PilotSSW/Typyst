//
//  MenuToggleButton.swift
//  Typyst
//
//  Created by Sean Wolford on 10/11/21.
//

import Combine
import SwiftUI

struct MenuToggleButton: View {
    @Binding var toggleState: Bool
    @State private var isFullOpacity: Bool = false
    
    var body: some View {
        Button(action: { withAnimation { toggleState.toggle() }}) {
            Image(systemName: toggleState ? "chevron.left" : "chevron.right")
                .resizable()
                .frame(width: 9, height: 12)
                .padding(.horizontal, 13.5)
                .padding(.vertical, 12)
        }
        .buttonStyle(NeumorphicButtonStyle(backgroundColor: AppColor.buttonTertiary))
        .opacity(isFullOpacity ? 1.0 : 0.25)
        .scaleEffect(isFullOpacity ? 1.25 : 0.75)
        .padding(6)
        .onHover(perform: { isHovering in
            isFullOpacity = isHovering
        })
        .animation(.interactiveSpring()
                    .speed(0.5)
                    .delay(0.03))
    }
}

struct MenuToggleButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuToggleButton(toggleState: .constant(false))
    }
}
