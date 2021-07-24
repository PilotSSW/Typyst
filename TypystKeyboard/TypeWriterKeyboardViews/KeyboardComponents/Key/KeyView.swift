//
//  KeyView.swift
//  Typyst
//
//  Created by Sean Wolford on 7/6/21.
//

import SwiftUI

struct KeyView: View {
    @StateObject var viewModel: KeyViewModel

    var body: some View {
        Button {
            viewModel.onTap()
        } label: {
            let _ = print("displaying \(viewModel.displayText)")
            ZStack() {
                RoundedRectangle(cornerRadius: viewModel.cornerRadius, style: .circular)
                    .fill(Color.white)
                    .shadow(color: AppColor.objectShadowDark.opacity(0.66), radius: 2.5)

                RoundedRectangle(cornerRadius: viewModel.cornerRadius, style: .continuous)
                    .fill(viewModel.key == .space ? AppColor.objectShadowDark : Color.gray)
                    .padding(viewModel.innerPadding)

                Text(viewModel.displayText)
                    .asStyledText(textColor: .yellow)
                    .scaleEffect(1.25)
            }
        }
        .padding(viewModel.innerPadding)
        .frame(width: viewModel.keySize.width,
               height: viewModel.keySize.height,
               alignment: .center)
        .onHover(perform: { isHovering in
            viewModel.isHovering = isHovering
        })
//        .onTapGesture {
//            viewModel.onTap()
//        }
    }
}

struct KeyView_Previews: PreviewProvider {
    static var previews: some View {
        KeyView(viewModel: KeyViewModelFactory.createViewModel(keyCharacter: .b))
            .previewLayout(.sizeThatFits)
    }
}
