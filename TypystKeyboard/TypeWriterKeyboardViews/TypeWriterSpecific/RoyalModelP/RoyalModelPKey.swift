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
            if (viewModel.key != .space) {
                RoundedRectangle(cornerRadius: viewModel.cornerRadius, style: .circular)
                    .fill(Color.gray)
            }

            RoundedRectangle(cornerRadius: viewModel.cornerRadius, style: .continuous)
                .fill(viewModel.key == .space ?
                        AppColor.objectShadowDark :
                        Color(.displayP3, red: 220, green: 220, blue: 220, opacity: 1.0))
                .padding(viewModel.key == .space ? 0 : viewModel.innerPadding)

            Text(viewModel.displayText)
                //.asStyledText(textColor: .yellow)
                .scaleEffect(1.25)
                .frame(maxWidth: .infinity)
        }
        .shadow(color: AppColor.objectShadowDark.opacity(0.66),
                radius: 2.5,
                y: viewModel.keySize.height / 24)
    }
}

struct RoyalModelPKey_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = KeyViewModelFactory.createViewModel(keyCharacter: .m)
        RoyalModelPKey(viewModel: viewModel)
            .frame(width: viewModel.keySize.width,
                   height: viewModel.keySize.height,
                   alignment: .center)
            .previewLayout(.sizeThatFits)
    }
}
