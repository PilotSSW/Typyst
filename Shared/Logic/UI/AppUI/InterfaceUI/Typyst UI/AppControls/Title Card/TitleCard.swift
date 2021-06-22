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
    let typeWriterHandler = appDependencyContainer.typeWriterService

    func infoComponent() -> AnyView {
        if let typeWriter = typeWriterHandler.loadedTypewriter {
            return AnyView(VStack {
                TypeWriterInfo(state: typeWriter.state)
                    .layoutPriority(2)
            })
        }
        else { return AnyView(EmptyView()) }
    }

    var body: some View {
        VStack {
            Image("TypystIcon")
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            infoComponent()
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
