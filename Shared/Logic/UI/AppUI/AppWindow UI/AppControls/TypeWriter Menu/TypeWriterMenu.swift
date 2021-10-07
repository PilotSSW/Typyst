//
//  TypeWriterMenu.swift
//  Typyst
//
//  Created by Sean Wolford on 3/28/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct TypeWriterMenu: View {
    var options: TypeWriterMenuOptions

    var body: some View {
        LazyVStack(spacing: 12) {
            ForEach(Array(options.typeWriters.enumerated()), id: \.offset) { (index, option) in
                TypeWriterCard(optionInfo: option)
            }
        }
    }
}

struct TypeWriterMenur_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterMenu(options: TypeWriterMenuOptions())
    }
}
