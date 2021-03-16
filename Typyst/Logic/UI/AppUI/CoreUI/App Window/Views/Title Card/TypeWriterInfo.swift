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
                    .font(.headline)
                    .foregroundColor(AppColor.textBodyLight)
                    .shadow(color: AppColor.textShadow, radius: 5)
                Text("Lines per Page: \(state.linesPerPage)")
                    .font(.headline)
                    .foregroundColor(AppColor.textBodyLight)
                    .shadow(color: AppColor.textShadow, radius: 5)
                Spacer()
            }
            HStack {
                Spacer()
                Text("Cursor Position: \(state.cursorIndex)")
                    .font(.title3)
                    .foregroundColor(AppColor.textBodyLight)
                    .shadow(color: AppColor.textShadow, radius: 5)
                Text("Current Line: \(state.lineIndex)")
                    .font(.title3)
                    .foregroundColor(AppColor.textBodyLight)
                    .shadow(color: AppColor.textShadow, radius: 5)
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
