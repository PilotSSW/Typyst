//
//  InterfaceAndControlsViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 9/20/21.
//

import Combine
import Foundation

class InterfaceAndControlsViewModel: ObservableObject {
    private var store = Set<AnyCancellable>()
    
    @Published
    private var settings = RootDependencyContainer.get().settingsService
    
    @Published
    private var compressView: Bool = false

    init() {
        settings.$logUsageAnalytics
            .sink { [weak self] isEnabled in
                guard let self = self else { return }
                self.showAnalyticsInfoCard = [.all, .analyticsInfoCard].contains(self.componentsShown) && isEnabled
            }
            .store(in: &store)
        
        $compressView
            .sink { [weak self] isCompressed in
                guard let self = self else { return }
                self.showDocumentsCard = !isCompressed &&
                    [.all, .documentsCard].contains(self.componentsShown)
            }
            .store(in: &store)
        
        $documentsCardFullHeight
            .sink { [weak self] isFullHeight in
                guard let self = self else { return }
                self.documentsListViewModel.isFullyExpanded = isFullHeight
            }
            .store(in: &store)
    }
    
    func setViewDimensions(_ size: CGSize) {
        let shouldCompressView = size.width <= 380
        
        if compressView != shouldCompressView { compressView = shouldCompressView }
    }
    
    /// MARK: Subview view-models
    lazy var analyticsInfoViewModel = AnalyticsInfoCardViewModel(subscriptions: &store)
    lazy var documentsListViewModel = DocumentsListViewModel()
    
    
    /// MARK: Visible views layout logic

    func requestFullViewFor(_ component: VisibleComponent) {
        componentsShown = componentsShown == .all
            ? component
            : .all

        showTitleCard = [.all, .titleCard, .analyticsInfoCard, .settingsCard].contains(componentsShown)
        showDocumentsCard = [.all, .documentsCard].contains(componentsShown) && !compressView
        showTypeWriterMenuCard = [.all, .typeWriterMenuCard].contains(componentsShown)
        showAnalyticsInfoCard = [.all, .analyticsInfoCard].contains(componentsShown) && settings.logUsageAnalytics
        showSettingsCard = [.all, .settingsCard].contains(componentsShown)

        typeWriterCardFullHeight = componentsShown == .typeWriterMenuCard
        documentsCardFullHeight = componentsShown == .documentsCard
    }
    
    enum VisibleComponent {
        case titleCard
        case documentsCard
        case typeWriterMenuCard
        case analyticsInfoCard
        case settingsCard
        case all
    }
    
    private(set) var componentsShown: VisibleComponent = .all

    @Published var showTitleCard: Bool = true
    @Published var showDocumentsCard: Bool = true
    @Published var showTypeWriterMenuCard: Bool = true
    @Published var showAnalyticsInfoCard: Bool = true
    @Published var showSettingsCard: Bool = true

    @Published var typeWriterCardFullHeight: Bool = false
    @Published var documentsCardFullHeight: Bool = false
}
