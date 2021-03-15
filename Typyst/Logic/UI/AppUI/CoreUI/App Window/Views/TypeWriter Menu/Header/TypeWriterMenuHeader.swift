//
// Created by Sean Wolford on 3/8/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct TypeWriterMenuHeader: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer(minLength: 6)
            Text("Choose a TypeWriter")
                .font(.largeTitle)
                .foregroundColor(AppColor.textHeader)
                .shadow(color: AppColor.textShadow, radius: 8)
            Spacer(minLength: 6)
        }
        .asStyledCardHeader(withBackgroundColor: AppColor.secondaryBackground)
    }
}

struct TypeWriterMenuHeader_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterMenuHeader()
    }
}
