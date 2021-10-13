//
//  TypeWriterInfoModal.swift
//  Typyst
//
//  Created by Sean Wolford on 10/6/21.
//

import SwiftUI

struct TypeWriterInfoModal: View {
    var optionInfo: TypeWriterMenuOption
    var onClose: (() -> Void) = {}

    var body: some View {
        Card(cardContentStyle: .straightCorner,
             cardContentBackgroundColor: AppColor.cardSecondaryBackground) {
            VStack(alignment: .center, spacing: 6) {
                HStack(spacing: 6) {
                    TypeWriterCardHeader(
                        maker: optionInfo.model.maker,
                        model: optionInfo.model.model,
                        modelName: optionInfo.model.name,
                        onClick: optionInfo.onClick,
                        maxHeight: 42)
                    
                    Button(action: onClose) {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .padding(15)
                    }
                    .buttonStyle(NeumorphicButtonStyle(backgroundColor: AppColor.buttonTertiary))
                }
                
                HSplitView() {
                    TypeWriterImageButton(onClick: nil,
                                          presentTypeWriterModal: false,
                                          optionInfo: optionInfo,
                                          imageSize: .large)
                        .frame(minWidth: 400, idealWidth: 600)
                        .padding(.trailing, optionInfo.model.description != nil ? 8 : 0)
                    
                    if let description = optionInfo.model.description {
                        ScrollView() {
                            Spacer()
                                .frame(width: 12)
                            
                            TypeWriterCardBody(description: description,
                                               compressTextBody: false)
                                .frame(minWidth: 180, idealWidth: 450, maxWidth: 750)
                            
                            Spacer()
                                .frame(width: 12)
                        }
                        .padding(.leading, 8)
                    }
                }
            }.padding(8)
        }
        .padding(-4)
    }
}

struct TypeWriterWindow_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterInfoModal(optionInfo: TypeWriterMenuOption(.Olympia_SM3))
    }
}
