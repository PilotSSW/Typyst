//
//  AnalyticsInfoCard.swift
//  Typyst
//
//  Created by Sean Wolford on 3/19/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import Combine
import SwiftUI

struct AnalyticsInfoCard: View {
    @StateObject var viewModel = AnalyticsInfoCardViewModel(subscriptions: &RootDependencyContainer.get().subscriptions)
    var showInfo: Bool {
        viewModel.state == .logging
    }

    var onTitleClick: (() -> Void)? = nil

    var body: some View {
        Card(title: "Typing Speed", onTitleClick: onTitleClick) {
            VStack(spacing: 4) {
                if (showInfo) {
                    ForEach(viewModel.analyticsInfoItems, id:\.timeElapsed) { analyticsInfo in
                        AnalyticsInfoView(viewModel: analyticsInfo)
                            .animation(.easeInOut(duration: 0.33))
                            .layoutPriority(1)
                    }
                }

                AnalyticsInfoControls(viewModel: viewModel)
                    .layoutPriority(3)
            }
        }
    }
}

struct AnalyticsInfoCard_Previews: PreviewProvider {
    static var previews: some View {
        var subscriptions = Set<AnyCancellable>()
        let viewModel = AnalyticsInfoCardViewModel(subscriptions: &subscriptions)
        let timer = Timer(timeInterval: 2.0, repeats: true, block: { _ in
            viewModel.stopTimer()
            viewModel.startTimer()
        })
        timer.fire()
        return AnalyticsInfoCard(viewModel:viewModel)
    }
}
