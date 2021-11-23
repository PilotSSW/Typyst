//
//  RoyalModelPKey.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 7/25/21.
//

import KeyLogic
import SwiftUI

struct RoyalModelPKey: View {
    var viewModel: KeyViewModel

    var body: some View {
        ZStack() {
            if (viewModel.key == .space) {
                RoundedRectangle(cornerRadius: viewModel.cornerRadius, style: .continuous)
                    .fill(viewModel.key == .space
                            ? LinearGradient(gradient: Gradient(colors: [
                                Color(.displayP3, red: 45 / 255, green: 50 / 255, blue: 55 / 255, opacity: 1.0),
                                Color(.displayP3, red: 25 / 255, green: 30 / 255, blue: 45 / 255, opacity: 1.0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom)
                            : LinearGradient(gradient: Gradient(colors: [
                                Color(.displayP3, red: 200 / 255, green: 200 / 255, blue: 205 / 255, opacity: 1.0),
                                Color(.displayP3, red: 245 / 255, green: 245 / 255, blue: 255 / 255, opacity: 1.0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom))
            }
            else {
                let inset = viewModel.innerPadding

                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [
                            Color(.displayP3, red: 230 / 255, green: 230 / 255, blue: 235 / 255, opacity: 1.0),
                            Color(.displayP3, red: 170 / 255, green: 170 / 255, blue: 170 / 255, opacity: 1.0)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom))
                
                Circle()
                    .stroke(Color.gray, lineWidth: viewModel.keySize.width / 24)
                    .padding(.leading, inset)
                    .padding(.trailing, inset - (inset / 12))
                    .padding(.top, inset)
                    .padding(.bottom, inset - (inset / 12))
            }

            if ![.space].contains(viewModel.key) {
                Text(viewModel.displayText)
                    .asStyledText(
                        textSize: .custom(fontSize: viewModel.keySize.width / 2),
                        textColor: Color(hue: 0.08,
                                         saturation: 0.88,
                                         brightness: 0.65))
            }
        }
    }
}

struct RoyalModelPKey_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelSpace = KeyViewModelFactory.createViewModel(keyCharacter: .space)
        viewModelSpace.setSuggestedKeySize(CGSize(width: 350, height: 350))

        let viewModelA = KeyViewModelFactory.createViewModel(keyCharacter: .a)
        viewModelA.setSuggestedKeySize(CGSize(width: 350, height: 350))
        
        return VStack() {
            RoyalModelPKey(viewModel: viewModelSpace)
                .frame(width: viewModelSpace.keySize.width,
                       height: viewModelSpace.keySize.height,
                       alignment: .center)
                .padding(18)
                .previewLayout(.sizeThatFits)

            RoyalModelPKey(viewModel: viewModelA)
                .frame(width: viewModelA.keySize.width,
                       height: viewModelA.keySize.height,
                       alignment: .center)
                .padding(18)
                .previewLayout(.sizeThatFits)
        }
    }
}
