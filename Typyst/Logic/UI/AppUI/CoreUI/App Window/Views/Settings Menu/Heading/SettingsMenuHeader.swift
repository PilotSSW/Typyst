//
//  SettingsMenuHeader.swift
//  Typyst
//
//  Created by Sean Wolford on 3/8/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct SettingsMenuHeader: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer(minLength: 6)
            Text("Settings")
                .font(.largeTitle)
                .foregroundColor(AppColor.textHeader)
                .shadow(color: AppColor.textShadow, radius: 8)
            Spacer(minLength: 6)
        }
        .asStyledCardHeader(withBackgroundColor: AppColor.secondaryBackground)
    }
}

struct SettingsMenuHeader_Previews: PreviewProvider {
    static var previews: some View {
        SettingsMenuHeader()
    }
}
