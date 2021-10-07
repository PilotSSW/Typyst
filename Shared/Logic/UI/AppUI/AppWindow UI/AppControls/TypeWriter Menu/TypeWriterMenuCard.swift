//
//  TypeWriterMenu.swift
//  Typyst
//
//  Created by Sean Wolford on 2/23/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct TypeWriterMenuCard: View {
    @Binding var isFullHeight: Bool
    private var options: TypeWriterMenuOptions
    var onTitleClick: (() -> Void)? = nil

    init(withOptions options: TypeWriterMenuOptions = TypeWriterMenuOptions(),
         onTitleClick: (() -> Void)? = nil,
         isFullHeight: Binding<Bool> = .constant(false)) {
        self.options = options
        self.onTitleClick = onTitleClick
        self._isFullHeight = isFullHeight
    }

    var body: some View {
        Card(title: "Typewriters",
             cardContentStyle: isFullHeight ? .noStyleChild : .scrollableChildCard,
             onTitleClick: onTitleClick) {
            TypeWriterMenu(options: options)
        }
    }
}

struct TypeWriterMenu_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterMenuCard()
            .frame(width: 250, height: 650, alignment: .center)
    }
}


