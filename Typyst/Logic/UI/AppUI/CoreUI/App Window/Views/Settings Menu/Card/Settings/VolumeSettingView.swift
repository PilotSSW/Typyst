//
//  VolumeSetting.swift
//  Typyst
//
//  Created by Sean Wolford on 3/10/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct VolumeSetting: View {
    @ObservedObject
    var appSettings: AppSettings

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Main Volume")
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .foregroundColor(AppColor.textBody)
                .font(.title3)
                .shadow(color: AppColor.textShadow, radius: 4)
            HStack {
                Image(systemName: "minus")
                Slider(value: $appSettings.volumeSetting)
                    .accentColor(AppColor.buttonPrimary)
                    .shadow(color: AppColor.objectShadowDark, radius: 4)
                Image(systemName: "plus")
            }
        }

    }
}

struct VolumeSetting_Previews: PreviewProvider {
    static var previews: some View {
        VolumeSetting(appSettings: AppSettings.shared)
    }
}
