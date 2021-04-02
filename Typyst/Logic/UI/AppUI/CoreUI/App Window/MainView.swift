//
//  MainView.swift
//  Typyst
//
//  Created by Sean Wolford on 3/13/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.displayP3, red: 0/256, green: 0/256, blue: 0/256))
                .blur(radius: 35)
                .opacity(0.55)
                .luminanceToAlpha()
                .edgesIgnoringSafeArea(.all)

            Rectangle()
                .fill(Color(.displayP3, red: 55/256, green: 55/256, blue: 85/256))
                .blur(radius: 5)
                .opacity(0.55)
                .edgesIgnoringSafeArea(.all)

            ScrollView(.vertical, showsIndicators: false) {
                Spacer()
                    .frame(minHeight: 8)
                    .layoutPriority(1)

                Typyst()
                    .padding(.horizontal, 12)
                    .frame(minHeight: 800, maxHeight: .infinity)
                    .layoutPriority(2)

                Spacer()
                    .frame(minHeight: 24)
                    .layoutPriority(1)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity,
                   alignment: .center)
        }
        .frame(minWidth: 312, idealWidth: 320, maxWidth: 450,
               minHeight: 300, idealHeight: 1880, maxHeight: 3840)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .frame(width: 300, height: 1400)
    }
}
