//
// Created by Sean Wolford on 3/8/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct TypeWriterMenuHeader: View {

    var body: some View {
        CardHeaderView(backgroundColor: AppColor.typeWriterCardBodyBackground,
                       contentView: AnyView (
                            VStack(alignment: .center) {
                                Spacer(minLength: 6)
                                Text("Choose a TypeWriter")
                                    .font(.largeTitle)
                                    .foregroundColor(AppColor.textHeader)
                                    .shadow(color: AppColor.textShadow, radius: 4)
                                Spacer(minLength: 6)
                        })
        )
    }
}
