//
//  TitleCard.swift
//  Typyst
//
//  Created by Sean Wolford on 3/13/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import Combine
import SwiftUI

struct TitleCard: View {
    let typeWriterHandler = RootDependencyContainer.get().typeWriterService

    var body: some View {
        VStack {
            Image("TypystIcon")
                .resizable()
                .scaledToFit()
                .layoutPriority(1)

            if let typeWriter = typeWriterHandler.loadedTypewriter {
                TypeWriterStateView(state: typeWriter.state)
                    .layoutPriority(2)
            }
        }
        .frame(minWidth: 200, maxWidth: .infinity,
               minHeight: 200, maxHeight: 375,
               alignment: .center)
        .padding(.all, 12)
        .asParentCard(withColor: AppColor.cardPrimaryBackground)
    }
}

struct TitleCard_Previews: PreviewProvider {
    static var previews: some View {
        TitleCard()
            .frame(width: 317.0)
    }
}
