//
//  ResizableDragger.swift
//  Typyst (iOS)
//
//  Created by Sean Wolford on 4/30/21.
//

import SwiftUI

struct ResizableDragger: View {
    @State var showMessage: Bool = false
    var backgroundColor: Color

    var body: some View {
        HStack {
            if showMessage { Spacer() }

            Image("Icons/up-and-down-arrows")
                .resizable()
                .scaledToFit()
                .frame(height: 24, alignment: .center)
                .animation(.easeOut(duration: 0.25))

            if showMessage {
                Spacer().frame(width: 12)
                Text("Drag to resize")
                    .asStyledText()
                    .animation(.easeOut(duration: 0.75))
                Spacer()
            }
        }
        .asStyledCardHeader(withBackgroundColor: backgroundColor, withTopPadding: 0)
        .onHover(perform: { isHovering in
            showMessage = isHovering
        })

    }
}

struct ResizableDragger_Previews: PreviewProvider {
    static var previews: some View {
        ResizableDragger(backgroundColor: AppColor.buttonPrimary)
    }
}
