//
//  TitleCard.swift
//  Typyst
//
//  Created by Sean Wolford on 3/13/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct TitleCard: View {
    var body: some View {
        VStack {
            Image("TypystIcon")
                .resizable()
                .frame(minWidth: 200, maxWidth: .infinity,
                       minHeight: 200, maxHeight: .infinity,
                       alignment: .center)
                .scaledToFit()
        }
        .padding(.all, 24)
        .asParentCard(withColor: AppColor.primaryBackground)
    }
}

struct TitleCard_Previews: PreviewProvider {
    static var previews: some View {
        TitleCard()
    }
}
