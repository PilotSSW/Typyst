//
//  TypeWriterInfo.swift
//  Typyst
//
//  Created by Sean Wolford on 3/15/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct TypeWriterInfo: View {
    @ObservedObject
    var state: TypeWriterState

    @State var cursorIndex: Int = 0
    @State var marginWidth: Int = 0
    @State var lineIndex: Int = 0
    @State var linesPerPage: Int = 0

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Margin Width: \(state.marginWidth)")
                    .asLightStyledText(with: .headline)
                Text("Lines per Page: \(state.linesPerPage)")
                    .asLightStyledText(with: .headline)
                Spacer()
            }
            HStack {
                Spacer()
                Text("Cursor Position: \(state.cursorIndex)")
                    .asLightStyledText(with: .title3)
                Text("Current Line: \(state.lineIndex)")
                    .asLightStyledText(with: .title3)
                Spacer()
            }
        }
    }
}

//struct TypeWriterInfo_Previews: PreviewProvider {
//    static var previews: some View {
//        TypeWriterInfo()
//    }
//}
