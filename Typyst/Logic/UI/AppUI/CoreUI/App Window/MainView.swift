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
        ScrollView(.vertical, showsIndicators: false) {
            Typyst()
        }
        .frame(minWidth: 300, idealWidth: 320, maxWidth: 450,
               minHeight: 300, idealHeight: 1880, maxHeight: 3840)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .frame(width: 300, height: 1400)
    }
}
