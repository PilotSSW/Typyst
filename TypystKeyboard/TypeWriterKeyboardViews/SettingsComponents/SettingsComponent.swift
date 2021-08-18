//
//  SettingsComponent.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 8/15/21.
//

import SwiftUI

struct SettingsComponent: View {
    var goBackAction: (() -> Void)? = nil

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 0) {
                Spacer()

                Button(action: {
                    goBackAction?()
                }) {
                    Text("Return to Keyboard")
                        .asStyledText(with: .title3)
                }
                .buttonStyle(NeumorphicButtonStyle(backgroundColor: AppColor.buttonTertiary))
                .padding(.top, 6)

                Spacer(minLength: 18)

                VolumeSetting()
                    .layoutPriority(1)

                Divider()
                    .padding(.bottom, 12)

                TypeWriterSettings()
                    .layoutPriority(1)

                Divider()
                    .padding(.bottom, 12)

                AppSettingsView()
                    .layoutPriority(1)

                Spacer()
            }
            .padding(.horizontal, 12)
            .asChildCard(withColor: AppColor.cardSecondaryBackground)
            .padding(.horizontal, 4)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous).inset(by: 4))
        .asScrollableCard(withColor: AppColor.cardPrimaryBackground)
    }
}

struct SettingsComponent_Previews: PreviewProvider {
    static var previews: some View {
        SettingsComponent()
            .previewLayout(.sizeThatFits)
            .environmentObject(AppSettings())
    }
}
