//
//  DocumentsListRowBackground.swift
//  Typyst
//
//  Created by Sean Wolford on 10/12/21.
//

import Combine
import SwiftUI

struct DocumentsListRowBackground: View {
    @Binding var isHovering: Bool
    @Binding var isSelected: Bool
    
    var body: some View {        
        ZStack() {
            if (isHovering && isSelected) {
                AppColor.buttonPrimary
                    .opacity(0.97)
            }
            else if (isHovering) {
                AppColor.buttonSecondary
                    .opacity(0.97)
            }
            else if (isSelected) {
                AppColor.buttonPrimary
                    .opacity(0.97)
            }
            else {
                AppColor.buttonOvertone
                    .opacity(0.97)
            }
            
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(AppGradients.buttonOutlineGradient(isPressed: !isHovering, opacity: isHovering ? 0.65 : 0.25),
                              lineWidth: 1.25,
                              antialiased: true)
        }
        .transition(.opacity)
        .animation(.easeInOut(duration: 0.25))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
        .neumorphicShadow(shadowIntensity: isHovering ? .tooFuckingStrong : .mediumLight,
                          radius: isHovering ? 4 : 1,
                          x: 0,
                          y: isHovering ? 2 : 0)
        .padding(8)
    }
}

struct DocumentsListRowBackground_Previews: PreviewProvider {
    static var previews: some View {
        VStack() {
            ZStack {
                DocumentsListRowBackground(isHovering: .constant(false), isSelected: .constant(false))
                Text("No interaction")
            }
            ZStack {
                DocumentsListRowBackground(isHovering: .constant(true), isSelected: .constant(false))
                Text("Hovering")
            }
            ZStack {
                DocumentsListRowBackground(isHovering: .constant(false), isSelected: .constant(true))
                Text("Selected")
            }
            ZStack {
                DocumentsListRowBackground(isHovering: .constant(true), isSelected: .constant(true))
                Text("Selected and Hovering")
            }
        }
    }
}
