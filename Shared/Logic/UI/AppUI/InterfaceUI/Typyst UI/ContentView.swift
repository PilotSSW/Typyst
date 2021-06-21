//
//  ContentView.swift
//  Typyst
//
//  Created by Sean Wolford on 3/13/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var alertsHandler: AlertsService = appDependencyContainer.alertsService
    @State var currentAlert: Alert? = appDependencyContainer.alertsService.currentAlert

    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(AppColor.windowBackground)
                .edgesIgnoringSafeArea(.all)

            ScrollView(.vertical, showsIndicators: false) {
                Spacer()
                    .frame(minHeight: 32)
                    .layoutPriority(1)

                InterfaceAndControls()
                    .padding(.horizontal, 12)
                    .frame(minHeight: 800)
                    .layoutPriority(2)

                Spacer()
                    .frame(minHeight: 24)
                    .layoutPriority(1)
            }
        }
        .alert(item: $currentAlert, content: { alertItem in
            createSwiftUIAlert(alertItem, alertsHandler: alertsHandler)
        })
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(currentAlert: appDependencyContainer.alertsHandler.$currentAlert)
//            .frame(width: 300, height: 1400)
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
