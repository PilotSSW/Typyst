//
//  SettingsComponent.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 8/15/21.
//

import SwiftUI

struct SettingsComponent: View {
    var goBackAction: (() -> Void)? = nil
    let typeWriterOptions: TypeWriterMenuOptions = TypeWriterMenuOptions()

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 6) {
                Button(action: {
                    goBackAction?()
                }) {
                    Text("Return to Keyboard")
                        .asStyledText(with: .title3)
                }
                .buttonStyle(NeumorphicButtonStyle(backgroundColor: AppColor.buttonTertiary))

                TypeWriterSelector(options: typeWriterOptions)
                    .padding(.vertical, 6)

                Divider()

                VolumeSetting()
                    .layoutPriority(1)

                Divider()

                TypeWriterSettings()
                    .layoutPriority(1)

                Divider()

                AppSettingsView()
                    .layoutPriority(1)
            }
            .padding(12)
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
