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
    let typeWriterHandler = appDependencyContainer.typeWriterHandler

    func infoComponent() -> AnyView {
        if let typeWriter = typeWriterHandler.loadedTypewriter {
            return AnyView(VStack {
                Spacer()
                TypeWriterInfo(state: typeWriter.state)
                    .padding(.bottom, 12)
                    .layoutPriority(2)
                    .padding(.horizontal, 8)
            })
        }
        else { return AnyView(EmptyView()) }
    }

    var body: some View {
        VStack {
            Image("TypystIcon")
                .resizable()
                .scaledToFit()
                .frame(minWidth: 200, maxWidth: .infinity,
                       minHeight: 200, maxHeight: .infinity,
                       alignment: .center)
                .shadow(color: AppColor.objectShadowDark,
                        radius: 16)
                .padding(.all, 12)
                .layoutPriority(1)
            infoComponent()
        }
        .asParentCard(withColor: AppColor.cardPrimaryBackground)
    }
}

struct TitleCard_Previews: PreviewProvider {
    static var previews: some View {
        TitleCard()
    }
}
