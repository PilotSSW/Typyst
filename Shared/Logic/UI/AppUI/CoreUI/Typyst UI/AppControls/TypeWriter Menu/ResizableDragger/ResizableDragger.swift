//
//  ResizableDragger.swift
//  Typyst (iOS)
//
//  Created by Sean Wolford on 4/30/21.
//

import SwiftUI

struct ResizableDragger: View {
    var backgroundColor: Color

    var body: some View {
        Image("Icons/up-and-down-arrows")
            .resizable()
            .scaledToFit()
            .frame(height: 24, alignment: .center)
            .asStyledCardHeader(withBackgroundColor: backgroundColor, withTopPadding: 0)
    }
}

struct ResizableDragger_Previews: PreviewProvider {
    static var previews: some View {
        ResizableDragger(backgroundColor: AppColor.buttonPrimary)
    }
}
