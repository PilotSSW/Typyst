//
//  TypeWriterInfoModal.swift
//  Typyst
//
//  Created by Sean Wolford on 10/6/21.
//

import SwiftUI

struct TypeWriterInfoModal: View {
    var optionInfo: TypeWriterMenuOption

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            Card(cardContentStyle: .roundedCornerChild) {
                VStack(alignment: .center, spacing: 6) {
                    TypeWriterCardHeader(
                            maker: optionInfo.model.maker,
                            model: optionInfo.model.model,
                            modelName: optionInfo.model.name,
                            onClick: optionInfo.onClick)

                    TypeWriterImageButton(typeWriterModel: optionInfo.modelType,
                                          imageSize: .large)

                    if let description = optionInfo.model.description {
                        Divider().padding(.horizontal, 24)

                        TypeWriterCardBody(description: description)
                    }
                }.padding(6)
            }
            .frame(minWidth:  max(350, size.width * 0.25),
                   idealWidth: max(350, size.width * 0.75),
                   maxWidth: max(350, size.width * 0.9),
                   minHeight: max(350, size.height * 0.25),
                   idealHeight: max(350, size.height * 0.75),
                   maxHeight: max(350, size.height * 0.9),
                   alignment: .center)
        }
//        .frame(minWidth: (NSApp.mainWindow?.frame.width ?? 480) * 0.1,
//               idealWidth: (NSApp.mainWindow?.frame.width ?? 800) * 0.75,
//               maxWidth: (NSApp.mainWindow?.frame.width ?? 800) * 0.9,
//               minHeight: (NSApp.mainWindow?.frame.height ?? 480) * 0.1,
//               idealHeight: (NSApp.mainWindow?.frame.height ?? 800) * 0.75,
//               maxHeight: (NSApp.mainWindow?.frame.height ?? 800) * 0.9,
//               alignment: .center)
    }
}

struct TypeWriterWindow_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterInfoModal(optionInfo: TypeWriterMenuOption(.Olympia_SM3))
    }
}
