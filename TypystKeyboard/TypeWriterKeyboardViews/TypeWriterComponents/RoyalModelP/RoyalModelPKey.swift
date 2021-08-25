//
//  RoyalModelPKey.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 7/25/21.
//

import SwiftUI

struct RoyalModelPKey: View {
    var viewModel: KeyViewModel

    var body: some View {
        ZStack() {
            let inset = viewModel.key == .space
                ? 0
                : viewModel.innerPadding
            
            if (viewModel.key != .space) {
                RoundedRectangle(cornerRadius: viewModel.cornerRadius - inset, style: .circular)
                    .fill(LinearGradient(gradient: Gradient(colors: [
                        Color(.displayP3, red: 210 / 255, green: 210 / 255, blue: 220 / 255, opacity: 1.0),
                        Color(.displayP3, red: 170 / 255, green: 170 / 255, blue: 170 / 255, opacity: 1.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom))
            }

            RoundedRectangle(cornerRadius: viewModel.cornerRadius + inset, style: .continuous)
                .stroke(Color.gray)
                .padding(inset - inset / 16)
            
            RoundedRectangle(cornerRadius: viewModel.cornerRadius + inset, style: .continuous)
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
                .padding(inset)

            Text(viewModel.displayText)
                .asStyledText(textColor: Color(hue: 0.08,
                                               saturation: 0.88,
                                               brightness: 0.95))
                .scaleEffect(1.25)
                .frame(maxWidth: .infinity)
        }
        .shadow(color: AppColor.objectShadowDark.opacity(0.25),
                radius: 5.0,
                y: viewModel.keySize.height / 8)
    }
}

struct RoyalModelPKey_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelSpace = KeyViewModelFactory.createViewModel(keyCharacter: .space)
        viewModelSpace.setSuggestedKeySize(CGSize(width: 35, height: 35))

        let viewModelA = KeyViewModelFactory.createViewModel(keyCharacter: .a)
        viewModelSpace.setSuggestedKeySize(CGSize(width: 35, height: 35))
        
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
