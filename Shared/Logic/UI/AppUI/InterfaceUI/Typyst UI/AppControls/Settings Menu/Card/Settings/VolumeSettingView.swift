//
//  VolumeSetting.swift
//  Typyst
//
//  Created by Sean Wolford on 3/10/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct VolumeSetting: View {
    @StateObject
    var appSettings: AppSettings = RootDependencyContainer.get().appSettings

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Main Volume")
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .asStyledText(with: .title3)
            HStack {
                Image(systemName: "minus")
                Slider(value: $appSettings.volumeSetting)
                    .accentColor(AppColor.buttonPrimary)
                Image(systemName: "plus")
            }
        }

    }
}

struct VolumeSetting_Previews: PreviewProvider {
    static var previews: some View {
        VolumeSetting()
    }
}
