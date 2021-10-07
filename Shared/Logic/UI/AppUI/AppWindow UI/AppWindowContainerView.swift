//
//  ContentView.swift
//  Typyst
//
//  Created by Sean Wolford on 3/13/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct AppWindowContainerView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var alertsService: AlertsService

    @State var string = ""

    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(AppColor.windowBackground)
                .edgesIgnoringSafeArea(.all)

            AppWindowView()
        }
        .alert(item: $alertsService.currentAlert, content: { alertItem in
            AlertUI.instance.createSwiftUIAlert(alertItem, alertsService: alertsService)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppWindowContainerView()
            .frame(width: 300, height: 1400)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
