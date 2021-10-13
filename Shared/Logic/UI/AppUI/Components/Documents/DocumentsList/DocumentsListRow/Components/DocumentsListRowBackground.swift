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
                AppColor.buttonWarning
                    .opacity(0.5)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.33))
            }
            else if (isHovering) {
                AppColor.buttonSecondary
                    .opacity(0.5)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.33))
            }
            else if (isSelected) {
                AppColor.buttonPrimary
                    .opacity(0.5)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.33))
            }
            else {
                AppColor.buttonOvertone
                    .opacity(0.5)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.33))
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
        .padding(8)
    }
}

struct DocumentsListRowBackground_Previews: PreviewProvider {
    static var previews: some View {
        VStack() {
            DocumentsListRowBackground(isHovering: .constant(false), isSelected: .constant(false))
            DocumentsListRowBackground(isHovering: .constant(true), isSelected: .constant(false))
            DocumentsListRowBackground(isHovering: .constant(false), isSelected: .constant(true))
            DocumentsListRowBackground(isHovering: .constant(true), isSelected: .constant(true))
        }
    }
}
