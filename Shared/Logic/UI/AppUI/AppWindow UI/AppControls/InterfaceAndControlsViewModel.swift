//
//  InterfaceAndControlsViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 9/20/21.
//

import Combine
import Foundation

class InterfaceAndControlsViewModel: ObservableObject {
    var store = Set<AnyCancellable>()
    @Published
    var settings = RootDependencyContainer.get().settingsService

    enum VisibleComponent {
        case titleCard
        case documentsCard
        case typeWriterMenuCard
        case analyticsInfoCard
        case settingsCard
        case all
    }

    private(set) var componentsShown: VisibleComponent = .all

    init() {
        settings.$logUsageAnalytics
            .sink { [weak self] isEnabled in
                guard let self = self else { return }
                self.showAnalyticsInfoCard = [.all, .analyticsInfoCard].contains(self.componentsShown) && isEnabled
            }
            .store(in: &store)
    }

    func requestFullViewFor(_ component: VisibleComponent) {
        componentsShown = componentsShown == .all
            ? component
            : .all

        showTitleCard = [.all, .titleCard, .analyticsInfoCard, .settingsCard].contains(componentsShown)
        showDocumentsCard = [.all, .documentsCard].contains(componentsShown)
        showTypeWriterMenuCard = [.all, .typeWriterMenuCard].contains(componentsShown)
        showAnalyticsInfoCard = [.all, .analyticsInfoCard].contains(componentsShown) && settings.logUsageAnalytics
        showSettingsCard = [.all, .settingsCard].contains(componentsShown)

        typeWriterCardFullHeight = componentsShown == .typeWriterMenuCard
        documentsCardFullHeight = componentsShown == .documentsCard
    }

    @Published var showTitleCard: Bool = true
    @Published var showDocumentsCard: Bool = true
    @Published var showTypeWriterMenuCard: Bool = true
    @Published var showAnalyticsInfoCard: Bool = true
    @Published var showSettingsCard: Bool = true

    @Published var typeWriterCardFullHeight: Bool = false
    @Published var documentsCardFullHeight: Bool = false
}
