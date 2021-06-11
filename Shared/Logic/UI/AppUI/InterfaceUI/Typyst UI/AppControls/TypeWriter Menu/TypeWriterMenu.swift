//
//  TypeWriterMenu.swift
//  Typyst
//
//  Created by Sean Wolford on 2/23/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct TypeWriterMenu: View {
    @State private var height: CGFloat = 650
    private var options = TypeWriterMenuOptions()

    var body: some View {
        VStack(alignment: .center) {
            TypeWriterMenuHeader()
            TypeWriterMenuScrollableSelector(options: options)
            ResizableDragger(backgroundColor: AppColor.cardHeaderBackground)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            let translationHeight = gesture.translation.height
                            height += translationHeight / 32

                            if height <= 400 {
                                height = 400
                            }
                            else if height >= 1400 {
                                height = 1400
                            }
                        }
                )
                    
        }
        .asParentCard(withColor: AppColor.cardPrimaryBackground)
        .frame(height: height)
    }
}

struct TypeWriterMenu_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterMenu()
            .frame(width: 250, height: 650, alignment: .center)
    }
}


