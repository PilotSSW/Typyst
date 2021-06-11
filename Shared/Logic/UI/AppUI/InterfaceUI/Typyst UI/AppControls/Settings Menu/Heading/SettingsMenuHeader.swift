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
                .asStyledText(with: .largeTitle)
            Spacer(minLength: 6)
        }
        .asStyledCardHeader(withBackgroundColor: AppColor.cardHeaderBackground, withBottomPadding: 0)
    }
}

struct SettingsMenuHeader_Previews: PreviewProvider {
    static var previews: some View {
        SettingsMenuHeader()
    }
}
