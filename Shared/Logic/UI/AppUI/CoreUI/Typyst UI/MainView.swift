//
//  MainView.swift
//  Typyst
//
//  Created by Sean Wolford on 3/13/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var alertsHandler = AppCore.instance.alertsHandler

    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(AppColor.windowBackground)
                .opacity(0.45)
                .edgesIgnoringSafeArea(.all)

            ScrollView(.vertical, showsIndicators: false) {
                Spacer()
                    .frame(minHeight: 8)
                    .layoutPriority(1)

                Typyst()
                    .padding(.horizontal, 12)
                    .frame(minHeight: 800)
                    .layoutPriority(2)

                Spacer()
                    .frame(minHeight: 24)
                    .layoutPriority(1)
            }
        }
        .alert(item: $alertsHandler.currentAlert, content: { alertItem in
            createSwiftUIAlert(alertItem)
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .frame(width: 300, height: 1400)
    }
}
