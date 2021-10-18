//
//  MenuToggleButton.swift
//  Typyst
//
//  Created by Sean Wolford on 10/11/21.
//

import Combine
import SwiftUI

struct MenuToggleButton: View {
    var buttonValue: AppWindowViewModel.InterfaceControlPosition
    @Binding var isSelected: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                isSelected = true
            }}) {
            HStack() {
                buttonText()
                
                buttonIcon()
                    .frame(width: 9, height: 12)
            }
            .padding(.horizontal, 13.5)
            .padding(.vertical, 12)
            .neumorphicShadow(shadowIntensity: .strong)
        }
        .buttonStyle(NeumorphicButtonStyle(backgroundColor: isSelected
                                           ? AppColor.buttonPrimary
                                           : AppColor.buttonTertiary))
    }
    
    private func buttonIcon() -> some View {
        var imageName: String
        switch(buttonValue) {
        case .above: imageName = "chevron.up"
        case .closed: imageName = "chevron.left"
        case .inline: imageName = "chevron.right"
        }
        
        return Image(systemName: imageName)
            .resizable()
    }
    
    private func buttonText() -> some View {
        var text: String
        switch(buttonValue) {
        case .above: text = "Above"
        case .closed: text = "Closed"
        case .inline: text = "Inline"
        }
        
        return Text(text)
            .asStyledText()
    }
}

struct MenuToggleButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack() {
            MenuToggleButton(buttonValue: .closed, isSelected: .constant(false))
            MenuToggleButton(buttonValue: .inline, isSelected: .constant(false))
            MenuToggleButton(buttonValue: .above, isSelected: .constant(true))
        }
    }
}
